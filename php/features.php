<?php
declare(strict_types=1);

// Thesmsworks SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/AuditFeature.php';
require_once __DIR__ . '/feature/CacheFeature.php';
require_once __DIR__ . '/feature/ClienttrackFeature.php';
require_once __DIR__ . '/feature/CostFeature.php';
require_once __DIR__ . '/feature/DebugFeature.php';
require_once __DIR__ . '/feature/IdempotencyFeature.php';
require_once __DIR__ . '/feature/LogFeature.php';
require_once __DIR__ . '/feature/MetricsFeature.php';
require_once __DIR__ . '/feature/NetsimFeature.php';
require_once __DIR__ . '/feature/PagingFeature.php';
require_once __DIR__ . '/feature/ProxyFeature.php';
require_once __DIR__ . '/feature/RatelimitFeature.php';
require_once __DIR__ . '/feature/RbacFeature.php';
require_once __DIR__ . '/feature/RetryFeature.php';
require_once __DIR__ . '/feature/SecretsFeature.php';
require_once __DIR__ . '/feature/StreamingFeature.php';
require_once __DIR__ . '/feature/TelemetryFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';
require_once __DIR__ . '/feature/TimeoutFeature.php';
require_once __DIR__ . '/feature/ValidateFeature.php';


class ThesmsworksFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new ThesmsworksBaseFeature();
            case "audit":
                return new ThesmsworksAuditFeature();
            case "cache":
                return new ThesmsworksCacheFeature();
            case "clienttrack":
                return new ThesmsworksClienttrackFeature();
            case "cost":
                return new ThesmsworksCostFeature();
            case "debug":
                return new ThesmsworksDebugFeature();
            case "idempotency":
                return new ThesmsworksIdempotencyFeature();
            case "log":
                return new ThesmsworksLogFeature();
            case "metrics":
                return new ThesmsworksMetricsFeature();
            case "netsim":
                return new ThesmsworksNetsimFeature();
            case "paging":
                return new ThesmsworksPagingFeature();
            case "proxy":
                return new ThesmsworksProxyFeature();
            case "ratelimit":
                return new ThesmsworksRatelimitFeature();
            case "rbac":
                return new ThesmsworksRbacFeature();
            case "retry":
                return new ThesmsworksRetryFeature();
            case "secrets":
                return new ThesmsworksSecretsFeature();
            case "streaming":
                return new ThesmsworksStreamingFeature();
            case "telemetry":
                return new ThesmsworksTelemetryFeature();
            case "test":
                return new ThesmsworksTestFeature();
            case "timeout":
                return new ThesmsworksTimeoutFeature();
            case "validate":
                return new ThesmsworksValidateFeature();
            default:
                return new ThesmsworksBaseFeature();
        }
    }

    /**
     * Does a generated feature class back this name? False for a name only
     * an options extend instance can supply (the station adopt path) - the
     * constructor uses this to skip make_feature for such names instead of
     * adding a stray BaseFeature.
     */
    public static function has_feature(string $name): bool
    {
        switch ($name) {
            case "base":
            case "audit":
            case "cache":
            case "clienttrack":
            case "cost":
            case "debug":
            case "idempotency":
            case "log":
            case "metrics":
            case "netsim":
            case "paging":
            case "proxy":
            case "ratelimit":
            case "rbac":
            case "retry":
            case "secrets":
            case "streaming":
            case "telemetry":
            case "test":
            case "timeout":
            case "validate":
                return true;
            default:
                return false;
        }
    }
}
