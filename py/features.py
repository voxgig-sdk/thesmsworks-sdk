# Thesmsworks SDK feature factory

from feature.base_feature import ThesmsworksBaseFeature
from feature.test_feature import ThesmsworksTestFeature


def _make_feature(name):
    features = {
        "base": lambda: ThesmsworksBaseFeature(),
        "test": lambda: ThesmsworksTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
