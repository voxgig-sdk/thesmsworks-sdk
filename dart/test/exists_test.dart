import 'harness.dart';

import '../lib/ThesmsworksSDK.dart';

void tests() {
  describe('exists', () {
    test('test-mode', (t) async {
      final testsdk = ThesmsworksSDK.test();
      equal(true, null != testsdk);
    });
  });
}
