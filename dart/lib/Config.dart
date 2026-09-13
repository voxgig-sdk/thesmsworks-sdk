import 'feature/base/BaseFeature.dart';
import 'feature/test/TestFeature.dart';



// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'test': () => TestFeature(),

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
        'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'transport': 'base',
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
      'flash': <String, dynamic>{},
      'message': <String, dynamic>{},
      'one_time_password': <String, dynamic>{},
      'schedule': <String, dynamic>{},
      'swagger': <String, dynamic>{},
      'util': <String, dynamic>{},
    },
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'batch': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'id',
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
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'kind': 'param',
                    'name': 'id',
                    'orig': 'batchid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
              'kind': 'http',
              'method': 'GET',
              'orig': '/batch/{batchid}',
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'batchid': 'id',
                },
              },
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'batch',
                },
                <String, dynamic>{
                  'var': 'id',
                },
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'batch',
                '{id}',
              ],
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
          'short': 'Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.',
          'type': '`\$BOOLEAN`',
        },
        <String, dynamic>{
          'name': 'content',
          'req': true,
          'short': 'Message to send to the recipient',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'deliveryreporturl',
          'short': 'The url to which we should POST delivery reports to for this message.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'destinations',
          'req': true,
          'short': 'Telephone numbers of each of the recipients',
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'schedule',
          'short': 'Date-time at which to send the batch.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'sender',
          'req': true,
          'short': 'The sender of the message.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'tag',
          'short': 'An identifying label for the message, which you can use to filter and report on messages you\'ve sent later.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'ttl',
          'short': 'The number of minutes before the delivery report is deleted.',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'validity',
          'short': 'The optional number of minutes to attempt delivery before the message is marked as EXPIRED.',
          'type': '`\$NUMBER`',
        },
      ],
      'name': 'batch_message',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'batch',
                'any',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'batch',
                'schedule',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'batch',
                'send',
              ],
            },
          ],
        },
        'remove': <String, dynamic>{
          'input': 'data',
          'name': 'remove',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'kind': 'param',
                    'name': 'batchid',
                    'orig': 'batchid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
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
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'batchid',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'batches',
                'schedule',
                '{batchid}',
              ],
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[
          <dynamic>[
            'schedule',
          ],
        ],
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
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'balance',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'credits',
                'balance',
              ],
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'flash': <String, dynamic>{
      'fields': <dynamic>[],
      'name': 'flash',
      'op': <String, dynamic>{},
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'message': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'ai',
          'short': 'Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.',
          'type': '`\$BOOLEAN`',
        },
        <String, dynamic>{
          'name': 'content',
          'req': true,
          'short': 'Message to send to the recipient.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'credits',
          'short': 'The number of credits used on the message.',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'deliveryreporturl',
          'short': 'The url to which we should POST delivery reports to for this message.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'destination',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'type': '`\$STRING`',
            },
          },
          'req': true,
          'short': 'Telephone number of the recipient',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'from',
          'short': 'The date-time from which you would like matching messages',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'keyword',
          'short': 'The keyword used in the inbound message',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'limit',
          'short': 'The maximum number of messages that you would like returned in this call.',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'metadata',
          'short': 'An array of objects containing metadata key/value pairs that have been saved on messages.',
          'type': '`\$OBJECT`',
        },
        <String, dynamic>{
          'name': 'responseemail',
          'short': 'An optional list of email addresses to forward responses to this specific message to.',
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'schedule',
          'short': 'Date at which to send the message.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'sender',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'type': '`\$STRING`',
            },
          },
          'req': true,
          'short': 'The sender of the message.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'skip',
          'short': 'The number of results you would like to ignore before returning messages.',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'status',
          'short': 'The status of the messages you would like returned (either \'SENT\', \'DELIVERED\', \'EXPIRED\', \'UNDELIVERABLE\', \'REJECTED\' or \'INCOMING\')',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'tag',
          'short': 'An identifying label for the message, which you can use to filter and report on messages you\'ve sent later.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'to',
          'short': 'The date-time to which you would like matching messages',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'ttl',
          'short': 'The optional number of minutes before the delivery report is deleted.',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'unread',
          'short': 'In queries for incoming messages (\'status\' is \'INCOMING\'), specify whether you explicitly want unread messages (true) or read messages (false).',
          'type': '`\$BOOLEAN`',
        },
        <String, dynamic>{
          'name': 'validity',
          'short': 'The optional number of minutes to attempt delivery before the message is marked as EXPIRED.',
          'type': '`\$NUMBER`',
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
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'flash',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'message',
                'flash',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'schedule',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'message',
                'schedule',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'send',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'message',
                'send',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/messages',
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'messages',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'failed',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'messages',
                'failed',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'inbox',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'messages',
                'inbox',
              ],
            },
          ],
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'kind': 'param',
                    'name': 'id',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
              'kind': 'http',
              'method': 'GET',
              'orig': '/messages/{messageid}',
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'messageid': 'id',
                },
              },
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'var': 'id',
                },
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'messages',
                '{id}',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'schedule',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'messages',
                'schedule',
              ],
            },
          ],
        },
        'remove': <String, dynamic>{
          'input': 'data',
          'name': 'remove',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'kind': 'param',
                    'name': 'id',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
              'kind': 'http',
              'method': 'DELETE',
              'orig': '/messages/{messageid}',
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'messageid': 'id',
                },
              },
              'segments': <dynamic>[
                <String, dynamic>{
                  'lit': 'messages',
                },
                <String, dynamic>{
                  'var': 'id',
                },
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'messages',
                '{id}',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'kind': 'param',
                    'name': 'messageid',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
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
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'messageid',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'messages',
                'schedule',
                '{messageid}',
              ],
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[
          <dynamic>[
            'schedule',
          ],
        ],
      },
    },
    'one_time_password': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'destination',
          'short': 'The phone number of the recipient.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'length',
          'short': 'The length of the generated passcode.',
          'type': '`\$OBJECT`',
        },
        <String, dynamic>{
          'name': 'metadata',
          'short': 'A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.',
          'type': '`\$OBJECT`',
        },
        <String, dynamic>{
          'name': 'passcode',
          'short': 'A passcode you supply for use in the message template.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'sender',
          'short': 'The sender of the message.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'template',
          'short': 'A template to use as the content for the message.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'validity',
          'short': 'The length of time in seconds for which the generated passcode should be valid.',
          'type': '`\$NUMBER`',
        },
      ],
      'name': 'one_time_password',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'otp',
                'send',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'otp',
                'verify',
              ],
            },
          ],
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'kind': 'param',
                    'name': 'messageid',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
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
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'messageid',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'otp',
                '{messageid}',
              ],
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[
          <dynamic>[
            'otp',
          ],
        ],
      },
    },
    'schedule': <String, dynamic>{
      'fields': <dynamic>[],
      'name': 'schedule',
      'op': <String, dynamic>{},
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'swagger': <String, dynamic>{
      'fields': <dynamic>[],
      'name': 'swagger',
      'op': <String, dynamic>{},
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
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'kind': 'param',
                    'name': 'errorcode',
                    'orig': 'errorcode',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
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
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'errorcode',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'utils',
                'errors',
                '{errorcode}',
              ],
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
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
              'select': <String, dynamic>{
                '\$action': 'test',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'parts': <dynamic>[
                'utils',
                'test',
              ],
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[
          <dynamic>[
            'error',
          ],
        ],
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
