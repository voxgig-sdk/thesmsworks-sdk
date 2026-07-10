<?php
declare(strict_types=1);

// Swagger entity test

require_once __DIR__ . '/../thesmsworks_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class SwaggerEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = ThesmsworksSDK::test(null, null);
        $ent = $testsdk->Swagger(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = swagger_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach ([] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "swagger." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set THESMSWORKS_TEST_SWAGGER_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // Bootstrap entity data from existing test data.
        $swagger_ref01_data_raw = Vs::items(Helpers::to_map(
            Vs::getpath($setup["data"], "existing.swagger")));
        $swagger_ref01_data = null;
        if (count($swagger_ref01_data_raw) > 0) {
            $swagger_ref01_data = Helpers::to_map($swagger_ref01_data_raw[0][1]);
        }

    }
}

function swagger_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/swagger/SwaggerTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = ThesmsworksSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["swagger01", "swagger02", "swagger03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("THESMSWORKS_TEST_SWAGGER_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "THESMSWORKS_TEST_SWAGGER_ENTID" => $idmap,
        "THESMSWORKS_TEST_LIVE" => "FALSE",
        "THESMSWORKS_TEST_EXPLAIN" => "FALSE",
        "THESMSWORKS_APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["THESMSWORKS_TEST_SWAGGER_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["THESMSWORKS_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["THESMSWORKS_APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new ThesmsworksSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["THESMSWORKS_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["THESMSWORKS_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
