<?php
declare(strict_types=1);

// Thesmsworks SDK

require_once __DIR__ . '/utility/struct/Struct.php';
require_once __DIR__ . '/core/UtilityType.php';
require_once __DIR__ . '/core/Spec.php';
require_once __DIR__ . '/core/Helpers.php';

// Load utility registration
require_once __DIR__ . '/utility/Register.php';

// Load config and features
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/features.php';

use Voxgig\Struct\Struct;

// Features record diagnostic state on the client as dynamic properties
// (_retry, _cache, _metrics, ...); allow them explicitly (PHP 8.2+
// deprecates implicit dynamic properties).
#[\AllowDynamicProperties]
class ThesmsworksSDK
{
    public string $mode;
    public array $features;
    public ?array $options;

    private $_utility;
    private $_rootctx;

    public function __construct(array $options = [])
    {
        $this->mode = "live";
        $this->features = [];
        $this->options = null;

        $utility = new ThesmsworksUtility();
        $this->_utility = $utility;

        $config = ThesmsworksConfig::make_config();

        $this->_rootctx = ($utility->make_context)([
            "client" => $this,
            "utility" => $utility,
            "config" => $config,
            "options" => $options ?? [],
            "shared" => [],
        ], null);

        $this->options = ($utility->make_options)($this->_rootctx);

        if (Struct::getpath($this->options, "feature.test.active") === true) {
            $this->mode = "test";
        }

        $this->_rootctx->options = $this->options;

        // Add features in the resolved order (make_options puts an explicit
        // list order first, else defaults to test-first). Ordering matters: the
        // `test` feature installs the base mock transport and the transport
        // features (retry/cache/netsim/proxy/ratelimit) wrap whatever is
        // current, so `test` must be added before them to sit at the base.
        $feature_opts = ThesmsworksHelpers::to_map(Struct::getprop($this->options, "feature"));
        if ($feature_opts) {
            $featureorder = Struct::getpath($this->options, "__derived__.featureorder");
            if (is_array($featureorder)) {
                foreach ($featureorder as $fname) {
                    $fopts = ThesmsworksHelpers::to_map($feature_opts[$fname] ?? null);
                    if ($fopts && isset($fopts["active"]) && $fopts["active"] === true) {
                        ($utility->feature_add)($this->_rootctx, ThesmsworksFeatures::make_feature($fname));
                    }
                }
            }
        }

        // Add extension features.
        $extend_val = Struct::getprop($this->options, "extend");
        if (is_array($extend_val)) {
            foreach ($extend_val as $f) {
                if (is_object($f) && method_exists($f, 'get_name')) {
                    ($utility->feature_add)($this->_rootctx, $f);
                }
            }
        }

        // Initialize features.
        foreach ($this->features as $f) {
            ($utility->feature_init)($this->_rootctx, $f);
        }

        ($utility->feature_hook)($this->_rootctx, "PostConstruct");
    }

    public function options_map(): array
    {
        $out = Struct::clone($this->options);
        return is_array($out) ? $out : [];
    }

    public function get_utility()
    {
        return ThesmsworksUtility::copy($this->_utility);
    }

    public function get_root_ctx()
    {
        return $this->_rootctx;
    }

    public function prepare(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;
        $fetchargs = $fetchargs ?? [];

        $ctrl = ThesmsworksHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "prepare",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $opts = $this->options;
        $path = Struct::getprop($fetchargs, "path") ?? "";
        $path = is_string($path) ? $path : "";
        $method_val = Struct::getprop($fetchargs, "method") ?? "GET";
        $method_val = is_string($method_val) ? $method_val : "GET";
        $params = ThesmsworksHelpers::to_map(Struct::getprop($fetchargs, "params")) ?? [];
        $query = ThesmsworksHelpers::to_map(Struct::getprop($fetchargs, "query")) ?? [];
        $headers = ($utility->prepare_headers)($ctx);

        $base = Struct::getprop($opts, "base") ?? "";
        $base = is_string($base) ? $base : "";
        $prefix = Struct::getprop($opts, "prefix") ?? "";
        $prefix = is_string($prefix) ? $prefix : "";
        $suffix = Struct::getprop($opts, "suffix") ?? "";
        $suffix = is_string($suffix) ? $suffix : "";

        $ctx->spec = new ThesmsworksSpec([
            "base" => $base, "prefix" => $prefix, "suffix" => $suffix,
            "path" => $path, "method" => $method_val,
            "params" => $params, "query" => $query, "headers" => $headers,
            "body" => Struct::getprop($fetchargs, "body"),
            "step" => "start",
        ]);

        // Merge user-provided headers.
        $uh = Struct::getprop($fetchargs, "headers");
        if (is_array($uh)) {
            foreach ($uh as $k => $v) {
                $ctx->spec->headers[$k] = $v;
            }
        }

        [$_, $err] = ($utility->prepare_auth)($ctx);
        if ($err) {
            return ($utility->make_error)($ctx, $err);
        }

        [$fetchdef, $fd_err] = ($utility->make_fetch_def)($ctx);
        if ($fd_err) {
            return ($utility->make_error)($ctx, $fd_err);
        }
        return $fetchdef;
    }

    public function direct(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;

        // direct() is the raw-HTTP escape hatch: it never throws, it returns
        // an {ok, err, ...} dict. prepare() now raises on error, so catch it
        // and surface the failure through the dict instead.
        try {
            $fetchdef = $this->prepare($fetchargs);
        } catch (\Throwable $err) {
            return ["ok" => false, "err" => $err];
        }

        $fetchargs = $fetchargs ?? [];
        $ctrl = ThesmsworksHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "direct",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $url = $fetchdef["url"] ?? "";
        [$fetched, $fetch_err] = ($utility->fetcher)($ctx, $url, $fetchdef);

        if ($fetch_err) {
            return ["ok" => false, "err" => $fetch_err];
        }

        if ($fetched === null) {
            return [
                "ok" => false,
                "err" => $ctx->make_error("direct_no_response", "response: undefined"),
            ];
        }

        if (is_array($fetched)) {
            $status = ThesmsworksHelpers::to_int(Struct::getprop($fetched, "status"));
            $headers = Struct::getprop($fetched, "headers") ?? [];

            // No-body responses (204, 304) and explicit zero content-length
            // must skip JSON parsing — calling json() on an empty body errors.
            $content_length = is_array($headers) ? ($headers["content-length"] ?? null) : null;
            $no_body = $status === 204 || $status === 304 || (string)$content_length === "0";

            $json_data = null;
            if (!$no_body) {
                $jf = Struct::getprop($fetched, "json");
                if (is_callable($jf)) {
                    try {
                        $json_data = $jf();
                    } catch (\Throwable $e) {
                        // Non-JSON body — leave data null but keep status/ok.
                        $json_data = null;
                    }
                }
            }

            return [
                "ok" => $status >= 200 && $status < 300,
                "status" => $status,
                "headers" => Struct::getprop($fetched, "headers"),
                "data" => $json_data,
            ];
        }

        return [
            "ok" => false,
            "err" => $ctx->make_error("direct_invalid", "invalid response type"),
        ];
    }


    private $_batch = null;

    // Canonical facade: $client->Batch()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->batch()
    // resolves here too.
    public function Batch($data = null)
    {
        require_once __DIR__ . '/entity/batch_entity.php';
        if ($data === null) {
            if ($this->_batch === null) {
                $this->_batch = new BatchEntity($this, null);
            }
            return $this->_batch;
        }
        return new BatchEntity($this, $data);
    }


    private $_batch_message = null;

    // Canonical facade: $client->BatchMessage()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->batch_message()
    // resolves here too.
    public function BatchMessage($data = null)
    {
        require_once __DIR__ . '/entity/batch_message_entity.php';
        if ($data === null) {
            if ($this->_batch_message === null) {
                $this->_batch_message = new BatchMessageEntity($this, null);
            }
            return $this->_batch_message;
        }
        return new BatchMessageEntity($this, $data);
    }


    private $_credit = null;

    // Canonical facade: $client->Credit()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->credit()
    // resolves here too.
    public function Credit($data = null)
    {
        require_once __DIR__ . '/entity/credit_entity.php';
        if ($data === null) {
            if ($this->_credit === null) {
                $this->_credit = new CreditEntity($this, null);
            }
            return $this->_credit;
        }
        return new CreditEntity($this, $data);
    }


    private $_flash = null;

    // Canonical facade: $client->Flash()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->flash()
    // resolves here too.
    public function Flash($data = null)
    {
        require_once __DIR__ . '/entity/flash_entity.php';
        if ($data === null) {
            if ($this->_flash === null) {
                $this->_flash = new FlashEntity($this, null);
            }
            return $this->_flash;
        }
        return new FlashEntity($this, $data);
    }


    private $_message = null;

    // Canonical facade: $client->Message()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->message()
    // resolves here too.
    public function Message($data = null)
    {
        require_once __DIR__ . '/entity/message_entity.php';
        if ($data === null) {
            if ($this->_message === null) {
                $this->_message = new MessageEntity($this, null);
            }
            return $this->_message;
        }
        return new MessageEntity($this, $data);
    }


    private $_one_time_password = null;

    // Canonical facade: $client->OneTimePassword()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->one_time_password()
    // resolves here too.
    public function OneTimePassword($data = null)
    {
        require_once __DIR__ . '/entity/one_time_password_entity.php';
        if ($data === null) {
            if ($this->_one_time_password === null) {
                $this->_one_time_password = new OneTimePasswordEntity($this, null);
            }
            return $this->_one_time_password;
        }
        return new OneTimePasswordEntity($this, $data);
    }


    private $_schedule = null;

    // Canonical facade: $client->Schedule()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->schedule()
    // resolves here too.
    public function Schedule($data = null)
    {
        require_once __DIR__ . '/entity/schedule_entity.php';
        if ($data === null) {
            if ($this->_schedule === null) {
                $this->_schedule = new ScheduleEntity($this, null);
            }
            return $this->_schedule;
        }
        return new ScheduleEntity($this, $data);
    }


    private $_swagger = null;

    // Canonical facade: $client->Swagger()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->swagger()
    // resolves here too.
    public function Swagger($data = null)
    {
        require_once __DIR__ . '/entity/swagger_entity.php';
        if ($data === null) {
            if ($this->_swagger === null) {
                $this->_swagger = new SwaggerEntity($this, null);
            }
            return $this->_swagger;
        }
        return new SwaggerEntity($this, $data);
    }


    private $_util = null;

    // Canonical facade: $client->Util()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->util()
    // resolves here too.
    public function Util($data = null)
    {
        require_once __DIR__ . '/entity/util_entity.php';
        if ($data === null) {
            if ($this->_util === null) {
                $this->_util = new UtilEntity($this, null);
            }
            return $this->_util;
        }
        return new UtilEntity($this, $data);
    }



    public static function test(?array $testopts = null, ?array $sdkopts = null): self
    {
        $sdkopts = $sdkopts ?? [];
        $sdkopts = Struct::clone($sdkopts);
        $sdkopts = is_array($sdkopts) ? $sdkopts : [];

        $testopts = $testopts ?? [];
        $testopts = Struct::clone($testopts);
        $testopts = is_array($testopts) ? $testopts : [];
        $testopts["active"] = true;

        if (!isset($sdkopts["feature"])) {
            $sdkopts["feature"] = [];
        }
        $sdkopts["feature"]["test"] = $testopts;

        $sdk = new ThesmsworksSDK($sdkopts);
        $sdk->mode = "test";
        return $sdk;
    }
}
