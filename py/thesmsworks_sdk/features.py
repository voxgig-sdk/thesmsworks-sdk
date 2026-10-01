# Thesmsworks SDK feature factory

from thesmsworks_sdk.feature.base_feature import ThesmsworksBaseFeature
from thesmsworks_sdk.feature.audit_feature import ThesmsworksAuditFeature
from thesmsworks_sdk.feature.cache_feature import ThesmsworksCacheFeature
from thesmsworks_sdk.feature.clienttrack_feature import ThesmsworksClienttrackFeature
from thesmsworks_sdk.feature.cost_feature import ThesmsworksCostFeature
from thesmsworks_sdk.feature.debug_feature import ThesmsworksDebugFeature
from thesmsworks_sdk.feature.idempotency_feature import ThesmsworksIdempotencyFeature
from thesmsworks_sdk.feature.log_feature import ThesmsworksLogFeature
from thesmsworks_sdk.feature.metrics_feature import ThesmsworksMetricsFeature
from thesmsworks_sdk.feature.netsim_feature import ThesmsworksNetsimFeature
from thesmsworks_sdk.feature.paging_feature import ThesmsworksPagingFeature
from thesmsworks_sdk.feature.proxy_feature import ThesmsworksProxyFeature
from thesmsworks_sdk.feature.ratelimit_feature import ThesmsworksRatelimitFeature
from thesmsworks_sdk.feature.rbac_feature import ThesmsworksRbacFeature
from thesmsworks_sdk.feature.retry_feature import ThesmsworksRetryFeature
from thesmsworks_sdk.feature.secrets_feature import ThesmsworksSecretsFeature
from thesmsworks_sdk.feature.streaming_feature import ThesmsworksStreamingFeature
from thesmsworks_sdk.feature.telemetry_feature import ThesmsworksTelemetryFeature
from thesmsworks_sdk.feature.test_feature import ThesmsworksTestFeature
from thesmsworks_sdk.feature.timeout_feature import ThesmsworksTimeoutFeature
from thesmsworks_sdk.feature.validate_feature import ThesmsworksValidateFeature


_FEATURES = {
    "base": lambda: ThesmsworksBaseFeature(),
    "audit": lambda: ThesmsworksAuditFeature(),
    "cache": lambda: ThesmsworksCacheFeature(),
    "clienttrack": lambda: ThesmsworksClienttrackFeature(),
    "cost": lambda: ThesmsworksCostFeature(),
    "debug": lambda: ThesmsworksDebugFeature(),
    "idempotency": lambda: ThesmsworksIdempotencyFeature(),
    "log": lambda: ThesmsworksLogFeature(),
    "metrics": lambda: ThesmsworksMetricsFeature(),
    "netsim": lambda: ThesmsworksNetsimFeature(),
    "paging": lambda: ThesmsworksPagingFeature(),
    "proxy": lambda: ThesmsworksProxyFeature(),
    "ratelimit": lambda: ThesmsworksRatelimitFeature(),
    "rbac": lambda: ThesmsworksRbacFeature(),
    "retry": lambda: ThesmsworksRetryFeature(),
    "secrets": lambda: ThesmsworksSecretsFeature(),
    "streaming": lambda: ThesmsworksStreamingFeature(),
    "telemetry": lambda: ThesmsworksTelemetryFeature(),
    "test": lambda: ThesmsworksTestFeature(),
    "timeout": lambda: ThesmsworksTimeoutFeature(),
    "validate": lambda: ThesmsworksValidateFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
