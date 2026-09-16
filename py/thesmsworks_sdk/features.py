# Thesmsworks SDK feature factory

from thesmsworks_sdk.feature.base_feature import ThesmsworksBaseFeature
from thesmsworks_sdk.feature.debug_feature import ThesmsworksDebugFeature
from thesmsworks_sdk.feature.idempotency_feature import ThesmsworksIdempotencyFeature
from thesmsworks_sdk.feature.metrics_feature import ThesmsworksMetricsFeature
from thesmsworks_sdk.feature.paging_feature import ThesmsworksPagingFeature
from thesmsworks_sdk.feature.ratelimit_feature import ThesmsworksRatelimitFeature
from thesmsworks_sdk.feature.retry_feature import ThesmsworksRetryFeature
from thesmsworks_sdk.feature.test_feature import ThesmsworksTestFeature
from thesmsworks_sdk.feature.timeout_feature import ThesmsworksTimeoutFeature


_FEATURES = {
    "base": lambda: ThesmsworksBaseFeature(),
    "debug": lambda: ThesmsworksDebugFeature(),
    "idempotency": lambda: ThesmsworksIdempotencyFeature(),
    "metrics": lambda: ThesmsworksMetricsFeature(),
    "paging": lambda: ThesmsworksPagingFeature(),
    "ratelimit": lambda: ThesmsworksRatelimitFeature(),
    "retry": lambda: ThesmsworksRetryFeature(),
    "test": lambda: ThesmsworksTestFeature(),
    "timeout": lambda: ThesmsworksTimeoutFeature(),
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
