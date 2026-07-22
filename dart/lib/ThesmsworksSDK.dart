// Thesmsworks Dart SDK

import 'entity/BatchEntity.dart';
import 'entity/BatchMessageEntity.dart';
import 'entity/CreditEntity.dart';
import 'entity/FlashEntity.dart';
import 'entity/MessageEntity.dart';
import 'entity/OneTimePasswordEntity.dart';
import 'entity/ScheduleEntity.dart';
import 'entity/SwaggerEntity.dart';
import 'entity/UtilEntity.dart';


export 'ThesmsworksTypes.dart';
export 'entity/BatchEntity.dart';
export 'entity/BatchMessageEntity.dart';
export 'entity/CreditEntity.dart';
export 'entity/FlashEntity.dart';
export 'entity/MessageEntity.dart';
export 'entity/OneTimePasswordEntity.dart';
export 'entity/ScheduleEntity.dart';
export 'entity/SwaggerEntity.dart';
export 'entity/UtilEntity.dart';


// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'Config.dart';
import 'Spec.dart';
import 'ThesmsworksEntityBase.dart';
import 'ThesmsworksError.dart';
import 'feature/base/BaseFeature.dart';
import 'utility/ErrUtility.dart';
import 'utility/Utility.dart';

export 'Config.dart' show Config, config;
export 'ThesmsworksEntityBase.dart' show ThesmsworksEntityBase;
export 'ThesmsworksError.dart' show ThesmsworksError;
export 'feature/base/BaseFeature.dart' show BaseFeature;
export 'utility/Utility.dart' show Utility;

final Utility stdutil = Utility();

class ThesmsworksSDK {
  String mode = 'live';
  dynamic _options;
  final Utility _utility = Utility();
  List<dynamic> features = [];
  dynamic rootctx;

  // Feature activity tracking store (retry attempts, cache hits, spans, ...).
  final Map<String, dynamic> track = {};

  ThesmsworksSDK([dynamic options]) {
    rootctx = _utility.makeContext({
      'client': this,
      'utility': _utility,
      'config': config.toMap(),
      'options': options,
      'shared': {},
    });

    _options = _utility.makeOptions(rootctx);

    final struct = _utility.struct;

    if (true == struct.getpath(_options, 'feature.test.active')) {
      mode = 'test';
    }

    rootctx.options = _options;

    features = [];

    final featureAdd = _utility.featureAdd;
    final featureInit = _utility.featureInit;

    // Add features in the resolved order (makeOptions puts an explicit List
    // order first, else defaults to test-first). Ordering matters: the
    // `test` feature installs the base mock transport and the transport
    // features (retry/cache/netsim/proxy/ratelimit) wrap whatever is current,
    // so `test` must be added before them to sit at the base of the chain.
    final featureorder =
        struct.getpath(_options, '__derived__.featureorder') ?? [];
    for (final fname in featureorder) {
      final fopts = _options['feature'][fname];
      if (fopts is Map && true == fopts['active']) {
        featureAdd(rootctx, config.makeFeature(fname.toString()));
      }
    }

    if (null != _options['extend']) {
      for (final f in _options['extend']) {
        featureAdd(rootctx, f);
      }
    }

    for (final f in features) {
      featureInit(rootctx, f);
    }

    final featureHook = _utility.featureHook;
    featureHook(rootctx, 'PostConstruct');
  }

  dynamic options() {
    return _utility.struct.clone(_options);
  }

  Utility utility() {
    return _utility;
  }

  Future<dynamic> prepare([dynamic fetchargs]) async {
    final utility = _utility;

    final makeContext = utility.makeContext;
    final makeFetchDef = utility.makeFetchDef;
    final prepareHeaders = utility.prepareHeaders;
    final prepareAuth = utility.prepareAuth;

    fetchargs = fetchargs ?? {};

    final ctx = makeContext({
      'opname': 'prepare',
      'ctrl': fetchargs['ctrl'] ?? {},
    }, rootctx);

    final options = _options;

    // Build spec directly from SDK options + user-provided fetch args.
    final spec = Spec({
      'base': options['base'],
      'prefix': options['prefix'],
      'suffix': options['suffix'],
      'path': fetchargs['path'] ?? '',
      'method': fetchargs['method'] ?? 'GET',
      'params': fetchargs['params'] ?? {},
      'query': fetchargs['query'] ?? {},
      'body': fetchargs['body'],
      'step': 'start',
    });

    ctx.spec = spec;

    spec.headers = prepareHeaders(ctx);

    // Merge user-provided headers over SDK defaults.
    if (fetchargs['headers'] is Map) {
      (fetchargs['headers'] as Map).forEach((key, val) {
        spec.headers[key] = val;
      });
    }

    // Apply SDK auth (apikey, auth prefix, etc.)
    final authResult = prepareAuth(ctx);
    if (iserr(authResult)) {
      return authResult;
    }

    return makeFetchDef(ctx);
  }

  Future<dynamic> direct([dynamic fetchargs]) async {
    final utility = _utility;
    final fetcher = utility.fetcher;
    final makeContext = utility.makeContext;

    final fetchdef = await prepare(fetchargs);
    if (iserr(fetchdef)) {
      return fetchdef;
    }

    final ctx = makeContext({
      'opname': 'direct',
      'ctrl': (fetchargs ?? {})['ctrl'] ?? {},
    }, rootctx);

    try {
      final dynamic fetched =
          await Future.value(fetcher(ctx, fetchdef['url'], fetchdef));

      if (null == fetched) {
        return {
          'ok': false,
          'err': ctx.error('direct_no_response', 'response: undefined')
        };
      } else if (iserr(fetched)) {
        return {'ok': false, 'err': fetched};
      }

      final status = fetched['status'];

      // No body responses (204 No Content, 304 Not Modified) and explicit
      // zero content-length must skip JSON parsing.
      final headers = fetched['headers'];
      final contentLength =
          headers is Map ? headers['content-length'] : null;
      final noBody = 204 == status ||
          304 == status ||
          '0' == (null == contentLength ? null : contentLength.toString());

      dynamic json;
      if (!noBody) {
        try {
          final jsonFn = fetched['json'];
          json = jsonFn is Function
              ? await Future.value(jsonFn())
              : fetched['json'];
        } catch (_parseErr) {
          // Body wasn't valid JSON — surface the raw response rather than
          // throwing. data stays null; callers can inspect status/headers.
          json = null;
        }
      }

      return {
        'ok': status is num && status >= 200 && status < 300,
        'status': status,
        'headers': fetched['headers'],
        'data': json,
      };
    } catch (err) {
      return {'ok': false, 'err': err};
    }
  }


  // Entity access: `client.Batch().list()` / `client.Batch().load({'id': ...})`.
  BatchEntity Batch([dynamic entopts]) {
    return BatchEntity(this, entopts);
  }


  // Entity access: `client.BatchMessage().list()` / `client.BatchMessage().load({'id': ...})`.
  BatchMessageEntity BatchMessage([dynamic entopts]) {
    return BatchMessageEntity(this, entopts);
  }


  // Entity access: `client.Credit().list()` / `client.Credit().load({'id': ...})`.
  CreditEntity Credit([dynamic entopts]) {
    return CreditEntity(this, entopts);
  }


  // Entity access: `client.Flash().list()` / `client.Flash().load({'id': ...})`.
  FlashEntity Flash([dynamic entopts]) {
    return FlashEntity(this, entopts);
  }


  // Entity access: `client.Message().list()` / `client.Message().load({'id': ...})`.
  MessageEntity Message([dynamic entopts]) {
    return MessageEntity(this, entopts);
  }


  // Entity access: `client.OneTimePassword().list()` / `client.OneTimePassword().load({'id': ...})`.
  OneTimePasswordEntity OneTimePassword([dynamic entopts]) {
    return OneTimePasswordEntity(this, entopts);
  }


  // Entity access: `client.Schedule().list()` / `client.Schedule().load({'id': ...})`.
  ScheduleEntity Schedule([dynamic entopts]) {
    return ScheduleEntity(this, entopts);
  }


  // Entity access: `client.Swagger().list()` / `client.Swagger().load({'id': ...})`.
  SwaggerEntity Swagger([dynamic entopts]) {
    return SwaggerEntity(this, entopts);
  }


  // Entity access: `client.Util().list()` / `client.Util().load({'id': ...})`.
  UtilEntity Util([dynamic entopts]) {
    return UtilEntity(this, entopts);
  }



  static ThesmsworksSDK test([dynamic testoptsarg, dynamic sdkoptsarg]) {
    final struct = stdutil.struct;
    final setpath = struct.setpath;
    final getdef = struct.getdef;
    final clone = struct.clone;
    final setprop = struct.setprop;

    final sdkopts = getdef(clone(sdkoptsarg), {});
    final testopts = getdef(clone(testoptsarg), {});
    setprop(testopts, 'active', true);
    setpath(sdkopts, 'feature.test', testopts);

    final testsdk = ThesmsworksSDK(sdkopts);
    testsdk.mode = 'test';

    return testsdk;
  }

  ThesmsworksSDK tester([dynamic testopts, dynamic sdkopts]) {
    return ThesmsworksSDK.test(testopts, sdkopts);
  }

  Map<String, dynamic> toJSON() {
    return {'name': 'Thesmsworks'};
  }

  @override
  String toString() {
    return 'Thesmsworks ' + _utility.struct.jsonify(toJSON());
  }
}

typedef SDK = ThesmsworksSDK;
