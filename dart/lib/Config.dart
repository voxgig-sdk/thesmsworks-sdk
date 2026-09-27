import 'feature/base/BaseFeature.dart';
import 'feature/debug/DebugFeature.dart';
import 'feature/idempotency/IdempotencyFeature.dart';
import 'feature/metrics/MetricsFeature.dart';
import 'feature/paging/PagingFeature.dart';
import 'feature/ratelimit/RatelimitFeature.dart';
import 'feature/retry/RetryFeature.dart';
import 'feature/test/TestFeature.dart';
import 'feature/timeout/TimeoutFeature.dart';



// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'debug': () => DebugFeature(),
  'idempotency': () => IdempotencyFeature(),
  'metrics': () => MetricsFeature(),
  'paging': () => PagingFeature(),
  'ratelimit': () => RatelimitFeature(),
  'retry': () => RetryFeature(),
  'test': () => TestFeature(),
  'timeout': () => TimeoutFeature(),

};

// Per-feature plugin DEFINITIONS (voxgig/plugin `Definition` values), from
// the model's active plugin groups. A feature that takes a `plugins` option
// (secrets over sekreto) reads its own entry; a feature with no plugins has
// none. The named `show` imports above make each definition statically
// reachable, so an SDK carries exactly the plugin libraries its model
// selects - the same leanness the old side-effect registry bought, without
// a registry.
//
// Emitted UNCONDITIONALLY, empty when no group is active: SecretsFeature
// imports this name, and the feature source can be present in a tree whose
// model selects no plugin group at all. An emission conditional on the map
// having entries would make that tree fail `dart analyze`.
//
// ignore: non_constant_identifier_names
final Map<String, List<dynamic>> FEATURE_PLUGINS = <String, List<dynamic>>{
  
};

class Config {
  BaseFeature makeFeature(String fn) {
    final fc = FEATURE_CLASS[fn];
    if (null == fc) {
      // TODO: errors etc
      throw StateError('Unknown feature: ' + fn);
    }
    return fc();
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  bool hasFeature(String fn) => null != FEATURE_CLASS[fn];

  final Map<String, dynamic> main = <String, dynamic>{
    'name': 'Thesmsworks',
        'slug': 'thesmsworks',
    'version': '0.1.1',
    'target': 'dart',

  };

  final Map<String, dynamic> feature = <String, dynamic>{
        'debug': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'max': 100,
        'redact': <dynamic>[
          'authorization',
          'cookie',
          'set-cookie',
          'api-key',
          'apikey',
          'x-api-key',
          'idempotency-key',
        ],
      },
      'optspec': <String, dynamic>{
        'now': '`\$FUNCTION`',
        'onEntry': '`\$FUNCTION`',
      },
      'strict': false,
      'transport': 'none',
    },
    'idempotency': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'header': 'Idempotency-Key',
        'methods': <dynamic>[
          'POST',
          'PUT',
          'PATCH',
          'DELETE',
        ],
        'ops': <dynamic>[
          'create',
          'update',
          'remove',
        ],
      },
      'optspec': <String, dynamic>{
        'keygen': '`\$FUNCTION`',
      },
      'strict': false,
      'transport': 'none',
    },
    'metrics': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'optspec': <String, dynamic>{
        'now': '`\$FUNCTION`',
      },
      'strict': false,
      'transport': 'none',
    },
    'paging': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'afterVar': 'after',
        'cursorParam': 'cursor',
        'firstVar': 'first',
        'limitParam': 'limit',
        'pageParam': 'page',
        'startPage': 1,
      },
      'optspec': <String, dynamic>{
        'limit': '`\$NUMBER`',
        'ops': '`\$LIST`',
      },
      'strict': false,
      'transport': 'none',
    },
    'ratelimit': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'burst': 5,
        'rate': 5,
      },
      'optspec': <String, dynamic>{
        'now': '`\$FUNCTION`',
        'sleep': '`\$FUNCTION`',
      },
      'strict': false,
      'transport': 'wrap',
    },
    'retry': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'factor': 2,
        'maxDelay': 2000,
        'minDelay': 50,
        'retries': 2,
        'statuses': <dynamic>[
          408,
          425,
          429,
          500,
          502,
          503,
          504,
        ],
      },
      'optspec': <String, dynamic>{
        'jitter': '`\$BOOLEAN`',
        'sleep': '`\$FUNCTION`',
      },
      'strict': false,
      'transport': 'wrap',
    },
    'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'optspec': <String, dynamic>{
        'entity': '`\$MAP`',
        'net': '`\$MAP`',
      },
      'strict': false,
      'transport': 'base',
    },
    'timeout': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'ms': 30000,
      },
      'optspec': <String, dynamic>{
        'clearTimer': '`\$FUNCTION`',
        'setTimer': '`\$FUNCTION`',
      },
      'strict': false,
      'transport': 'wrap',
    },

  };

  // Rendered whole from the canonical config definition rather than assembled
  // slot by slot. Assembling it here meant `options.server` - the OpenAPI
  // server-variable defaults - was simply absent from this branch, so a
  // templated server URL produced a different config either side of the
  // threshold.
  final Map<String, dynamic> options = <String, dynamic>{
    'base': 'https://api.thesmsworks.co.uk/v1',
    'auth': <String, dynamic>{
      'prefix': '',
    },
    'headers': <String, dynamic>{
      'content-type': 'application/json',
    },
    'entity': <String, dynamic>{
      'batch': <String, dynamic>{},
      'batch_message': <String, dynamic>{},
      'credit': <String, dynamic>{},
      'message': <String, dynamic>{},
      'one_time_password': <String, dynamic>{},
      'util': <String, dynamic>{},
    },
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'batch': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'id',
          'title': 'Id',
          'type': '`\$STRING`',
        },
      ],
      'id': <String, dynamic>{
        'field': 'id',
        'name': 'id',
      },
      'name': 'batch',
      'op': <String, dynamic>{
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'GET',
              'orig': '/batch/{batchid}',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'batch',
                },
                <String, dynamic>{
                  'var': 'id',
                },
              ],
              'parts': <dynamic>[
                'batch',
                '{id}',
              ],
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'batchid': 'id',
                },
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'name': 'id',
                    'orig': 'batchid',
                    'type': '`\$STRING`',
                    'kind': 'param',
                    'reqd': true,
                  },
                ],
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'batch_message': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'ai',
          'title': 'Ai',
          'type': '`\$BOOLEAN`',
          'short': 'Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.',
        },
        <String, dynamic>{
          'name': 'content',
          'title': 'Content',
          'type': '`\$STRING`',
          'req': true,
          'short': 'Message to send to the recipient',
        },
        <String, dynamic>{
          'name': 'deliveryreporturl',
          'title': 'Deliveryreporturl',
          'type': '`\$STRING`',
          'short': 'The url to which we should POST delivery reports to for this message.',
        },
        <String, dynamic>{
          'name': 'destinations',
          'title': 'Destinations',
          'type': '`\$ARRAY`',
          'req': true,
          'short': 'Telephone numbers of each of the recipients',
        },
        <String, dynamic>{
          'name': 'schedule',
          'title': 'Schedule',
          'type': '`\$STRING`',
          'short': 'Date-time at which to send the batch.',
        },
        <String, dynamic>{
          'name': 'sender',
          'title': 'Sender',
          'type': '`\$STRING`',
          'req': true,
          'short': 'The sender of the message.',
        },
        <String, dynamic>{
          'name': 'tag',
          'title': 'Tag',
          'type': '`\$STRING`',
          'short': 'An identifying label for the message, which you can use to filter and report on messages you\'ve sent later.',
        },
        <String, dynamic>{
          'name': 'ttl',
          'title': 'Ttl',
          'type': '`\$NUMBER`',
          'short': 'The number of minutes before the delivery report is deleted.',
        },
        <String, dynamic>{
          'name': 'validity',
          'title': 'Validity',
          'type': '`\$NUMBER`',
          'short': 'The optional number of minutes to attempt delivery before the message is marked as EXPIRED.',
        },
      ],
      'name': 'batch_message',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/batch/any',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'batch',
                },
                <String, dynamic>{
                  'lit': 'any',
                },
              ],
              'parts': <dynamic>[
                'batch',
                'any',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{},
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/batch/schedule',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'batch',
                },
                <String, dynamic>{
                  'lit': 'schedule',
                },
              ],
              'parts': <dynamic>[
                'batch',
                'schedule',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{},
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/batch/send',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'batch',
                },
                <String, dynamic>{
                  'lit': 'send',
                },
              ],
              'parts': <dynamic>[
                'batch',
                'send',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{},
            },
          ],
        },
        'remove': <String, dynamic>{
          'input': 'data',
          'name': 'remove',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'DELETE',
              'orig': '/batches/schedule/{batchid}',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'batches',
                },
                <String, dynamic>{
                  'lit': 'schedule',
                },
                <String, dynamic>{
                  'var': 'batchid',
                },
              ],
              'parts': <dynamic>[
                'batches',
                'schedule',
                '{batchid}',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'name': 'batchid',
                    'orig': 'batchid',
                    'type': '`\$STRING`',
                    'kind': 'param',
                    'reqd': true,
                  },
                ],
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'batchid',
                ],
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'credit': <String, dynamic>{
      'fields': <dynamic>[],
      'name': 'credit',
      'op': <String, dynamic>{
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'GET',
              'orig': '/credits/balance',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'credits',
                },
                <String, dynamic>{
                  'lit': 'balance',
                },
              ],
              'parts': <dynamic>[
                'credits',
                'balance',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'balance',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'message': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'credits',
          'title': 'Credits',
          'type': '`\$NUMBER`',
          'short': 'The number of credits used on the message.',
        },
        <String, dynamic>{
          'name': 'destination',
          'title': 'Destination',
          'type': '`\$STRING`',
          'short': 'The phone number of the recipient.',
        },
        <String, dynamic>{
          'name': 'from',
          'title': 'From',
          'type': '`\$STRING`',
          'short': 'The date-time from which you would like matching messages',
        },
        <String, dynamic>{
          'name': 'id',
          'title': 'Id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'keyword',
          'title': 'Keyword',
          'type': '`\$STRING`',
          'short': 'The keyword used in the inbound message',
        },
        <String, dynamic>{
          'name': 'limit',
          'title': 'Limit',
          'type': '`\$NUMBER`',
          'short': 'The maximum number of messages that you would like returned in this call.',
        },
        <String, dynamic>{
          'name': 'metadata',
          'title': 'Metadata',
          'type': '`\$OBJECT`',
          'short': 'An array of objects containing metadata key/value pairs that have been saved on messages.',
        },
        <String, dynamic>{
          'name': 'sender',
          'title': 'Sender',
          'type': '`\$STRING`',
          'short': 'The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).',
        },
        <String, dynamic>{
          'name': 'skip',
          'title': 'Skip',
          'type': '`\$NUMBER`',
          'short': 'The number of results you would like to ignore before returning messages.',
        },
        <String, dynamic>{
          'name': 'status',
          'title': 'Status',
          'type': '`\$STRING`',
          'short': 'The status of the messages you would like returned (either \'SENT\', \'DELIVERED\', \'EXPIRED\', \'UNDELIVERABLE\', \'REJECTED\' or \'INCOMING\')',
        },
        <String, dynamic>{
          'name': 'to',
          'title': 'To',
          'type': '`\$STRING`',
          'short': 'The date-time to which you would like matching messages',
        },
        <String, dynamic>{
          'name': 'unread',
          'title': 'Unread',
          'type': '`\$BOOLEAN`',
          'short': 'In queries for incoming messages (\'status\' is \'INCOMING\'), specify whether you explicitly want unread messages (true) or read messages (false).',
        },
      ],
      'id': <String, dynamic>{
        'field': 'id',
        'name': 'id',
      },
      'name': 'message',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/message/flash',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'message',
                },
                <String, dynamic>{
                  'lit': 'flash',
                },
              ],
              'parts': <dynamic>[
                'message',
                'flash',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'flash',
              },
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/message/schedule',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'message',
                },
                <String, dynamic>{
                  'lit': 'schedule',
                },
              ],
              'parts': <dynamic>[
                'message',
                'schedule',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'schedule',
              },
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/message/send',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'message',
                },
                <String, dynamic>{
                  'lit': 'send',
                },
              ],
              'parts': <dynamic>[
                'message',
                'send',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'send',
              },
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/messages',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
              ],
              'parts': <dynamic>[
                'messages',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{},
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/messages/failed',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'lit': 'failed',
                },
              ],
              'parts': <dynamic>[
                'messages',
                'failed',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'failed',
              },
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/messages/inbox',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'lit': 'inbox',
                },
              ],
              'parts': <dynamic>[
                'messages',
                'inbox',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'inbox',
              },
            },
          ],
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'GET',
              'orig': '/messages/{messageid}',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'var': 'id',
                },
              ],
              'parts': <dynamic>[
                'messages',
                '{id}',
              ],
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'messageid': 'id',
                },
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'name': 'id',
                    'orig': 'messageid',
                    'type': '`\$STRING`',
                    'kind': 'param',
                    'reqd': true,
                  },
                ],
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'GET',
              'orig': '/messages/schedule',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'lit': 'schedule',
                },
              ],
              'parts': <dynamic>[
                'messages',
                'schedule',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'schedule',
              },
            },
          ],
        },
        'remove': <String, dynamic>{
          'input': 'data',
          'name': 'remove',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'DELETE',
              'orig': '/messages/{messageid}',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'var': 'id',
                },
              ],
              'parts': <dynamic>[
                'messages',
                '{id}',
              ],
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'messageid': 'id',
                },
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'name': 'id',
                    'orig': 'messageid',
                    'type': '`\$STRING`',
                    'kind': 'param',
                    'reqd': true,
                  },
                ],
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'DELETE',
              'orig': '/messages/schedule/{messageid}',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'lit': 'schedule',
                },
                <String, dynamic>{
                  'var': 'messageid',
                },
              ],
              'parts': <dynamic>[
                'messages',
                'schedule',
                '{messageid}',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'name': 'messageid',
                    'orig': 'messageid',
                    'type': '`\$STRING`',
                    'kind': 'param',
                    'reqd': true,
                  },
                ],
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'messageid',
                ],
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'one_time_password': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'destination',
          'title': 'Destination',
          'type': '`\$STRING`',
          'short': 'The phone number of the recipient.',
        },
        <String, dynamic>{
          'name': 'length',
          'title': 'Length',
          'type': '`\$OBJECT`',
          'short': 'The length of the generated passcode.',
        },
        <String, dynamic>{
          'name': 'metadata',
          'title': 'Metadata',
          'type': '`\$OBJECT`',
          'short': 'A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.',
        },
        <String, dynamic>{
          'name': 'passcode',
          'title': 'Passcode',
          'type': '`\$STRING`',
          'short': 'A passcode you supply for use in the message template.',
        },
        <String, dynamic>{
          'name': 'sender',
          'title': 'Sender',
          'type': '`\$STRING`',
          'short': 'The sender of the message.',
        },
        <String, dynamic>{
          'name': 'template',
          'title': 'Template',
          'type': '`\$STRING`',
          'short': 'A template to use as the content for the message.',
        },
        <String, dynamic>{
          'name': 'validity',
          'title': 'Validity',
          'type': '`\$NUMBER`',
          'short': 'The length of time in seconds for which the generated passcode should be valid.',
        },
      ],
      'name': 'one_time_password',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/otp/send',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'otp',
                },
                <String, dynamic>{
                  'lit': 'send',
                },
              ],
              'parts': <dynamic>[
                'otp',
                'send',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{},
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'POST',
              'orig': '/otp/verify',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'otp',
                },
                <String, dynamic>{
                  'lit': 'verify',
                },
              ],
              'parts': <dynamic>[
                'otp',
                'verify',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{},
            },
          ],
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'GET',
              'orig': '/otp/{messageid}',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'otp',
                },
                <String, dynamic>{
                  'var': 'messageid',
                },
              ],
              'parts': <dynamic>[
                'otp',
                '{messageid}',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'name': 'messageid',
                    'orig': 'messageid',
                    'type': '`\$STRING`',
                    'kind': 'param',
                    'reqd': true,
                  },
                ],
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'messageid',
                ],
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'util': <String, dynamic>{
      'fields': <dynamic>[],
      'name': 'util',
      'op': <String, dynamic>{
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'kind': 'http',
              'method': 'GET',
              'orig': '/utils/errors/{errorcode}',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'utils',
                },
                <String, dynamic>{
                  'lit': 'errors',
                },
                <String, dynamic>{
                  'var': 'errorcode',
                },
              ],
              'parts': <dynamic>[
                'utils',
                'errors',
                '{errorcode}',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'name': 'errorcode',
                    'orig': 'errorcode',
                    'type': '`\$STRING`',
                    'kind': 'param',
                    'reqd': true,
                  },
                ],
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'errorcode',
                ],
              },
            },
            <String, dynamic>{
              'kind': 'http',
              'method': 'GET',
              'orig': '/utils/test',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'utils',
                },
                <String, dynamic>{
                  'lit': 'test',
                },
              ],
              'parts': <dynamic>[
                'utils',
                'test',
              ],
              'rename': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'args': <String, dynamic>{},
              'select': <String, dynamic>{
                '\$action': 'test',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
  };

  // The pipeline context carries the config as a plain map.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'main': main,
        'feature': feature,
        'options': options,
        'entity': entity,
      };
}

final config = Config();
