# ProjectName SDK exists test

import pytest
from thesmsworks_sdk import ThesmsworksSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = ThesmsworksSDK.test(None, None)
        assert testsdk is not None
