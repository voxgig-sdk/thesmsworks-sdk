// ignore_for_file: unused_import, unused_local_variable, non_constant_identifier_names

import 'dart:convert';

import '../../harness.dart';
import '../../utility.dart';

import '../../../lib/ThesmsworksSDK.dart';

void tests() {
  describe('MessageDirect', () {
    test('direct-exists', (t) async {
      final sdk = ThesmsworksSDK({
        'system': {
          'fetch': (dynamic url, dynamic init) async => <String, dynamic>{}
        }
      });
      ok(null != sdk);
    });


    test('direct-load-message', (t) async {
      final setup = directSetup({'id': 'direct01'});
      if (maybeSkipControl(
          t, 'direct', 'direct-load-message', true == setup['live'])) {
        return;
      }
      if (skipIfMissingIds(t, setup, ["id01"])) {
        return;
      }
      final client = setup['client'];
      final calls = setup['calls'];

      final params = <String, dynamic>{};
      final query = <String, dynamic>{};
      if (true == setup['live']) {

      } else {
        params['id'] = 'direct01';
      }

      final result = await client.direct({
        'path': 'messages/{id}',
        'method': 'GET',
        'params': params,
        'query': query,
      });

      if (true == setup['live']) {
        // Live mode is lenient: synthetic IDs frequently 4xx. Skip rather
        // than fail when the load endpoint isn't reachable.
        if (true != result['ok'] ||
            result['status'] < 200 ||
            result['status'] >= 300) {
          return;
        }
      } else {
        ok(true == result['ok']);
        ok(200 == result['status']);
        ok(null != result['data']);
        ok('direct01' == result['data']['id']);
        ok(1 == calls.length);
        ok('GET' == calls[0]['init']['method']);
        ok(calls[0]['url'].toString().contains('direct01'));
      }
    });

  });
}


Map<String, dynamic> directSetup([dynamic mockres]) {
  final calls = <Map<String, dynamic>>[];

  final env = envOverride({
    'THESMSWORKS_TEST_MESSAGE_ENTID': <String, dynamic>{},
    'THESMSWORKS_TEST_LIVE': 'FALSE',
    'THESMSWORKS_APIKEY': 'NONE',
  });

  final live = 'TRUE' == env['THESMSWORKS_TEST_LIVE'];

  if (live) {
    final client = ThesmsworksSDK({
      'apikey': env['THESMSWORKS_APIKEY'],
    });

    dynamic idmap = env['THESMSWORKS_TEST_MESSAGE_ENTID'];
    if (idmap is String && idmap.startsWith('{')) {
      idmap = jsonDecode(idmap);
    }

    return {'client': client, 'calls': calls, 'live': live, 'idmap': idmap};
  }

  mockFetch(dynamic url, dynamic init) async {
    calls.add({'url': url, 'init': init});
    return {
      'status': 200,
      'statusText': 'OK',
      'headers': <String, dynamic>{},
      'json': () => mockres ?? {'id': 'direct01'},
    };
  }

  final client = ThesmsworksSDK({
    'base': 'http://localhost:8080',
    'system': {'fetch': mockFetch},
  });

  return {
    'client': client,
    'calls': calls,
    'live': live,
    'idmap': <String, dynamic>{},
  };
}

// direct() returns the raw response body. List endpoints often wrap the
// array in an envelope (e.g. { data: [...] }, { entities: [...] }). The
// test transforms the raw body to extract the first list — either the body
// itself or the first list property of an envelope map.
dynamic unwrapListData(dynamic data) {
  if (data is List) {
    return data;
  }
  if (data is Map) {
    for (final v in data.values) {
      if (v is List) {
        return v;
      }
    }
  }
  return null;
}
  
