import 'feature/base/BaseFeature.dart';
import 'feature/test/TestFeature.dart';


// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'test': () => TestFeature(),

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

  final Map<String, dynamic> main = <String, dynamic>{
    'name': 'Thesmsworks',
  };

  final Map<String, dynamic> feature = <String, dynamic>{
        'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
    },

  };

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

    }
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'batch': <String, dynamic>{
      'fields': <dynamic>[],
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
              'parts': <dynamic>[
                'batch',
                '{id}',
              ],
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'batchid': 'id',
                },
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
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
          'type': '`\$BOOLEAN`',
        },
        <String, dynamic>{
          'name': 'content',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'deliveryreporturl',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'destinations',
          'req': true,
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'schedule',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'sender',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'tag',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'ttl',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'validity',
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
              'parts': <dynamic>[
                'batch',
                'any',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/batch/schedule',
              'parts': <dynamic>[
                'batch',
                'schedule',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/batch/send',
              'parts': <dynamic>[
                'batch',
                'send',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
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
              'parts': <dynamic>[
                'batches',
                'schedule',
                '{batchid}',
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
              'parts': <dynamic>[
                'credits',
                'balance',
              ],
              'select': <String, dynamic>{
                '\$action': 'balance',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
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
          'type': '`\$BOOLEAN`',
        },
        <String, dynamic>{
          'name': 'content',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'credits',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'deliveryreporturl',
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
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'from',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'keyword',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'limit',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'metadata',
          'type': '`\$OBJECT`',
        },
        <String, dynamic>{
          'name': 'responseemail',
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'schedule',
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
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'skip',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'status',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'tag',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'to',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'ttl',
          'type': '`\$NUMBER`',
        },
        <String, dynamic>{
          'name': 'unread',
          'type': '`\$BOOLEAN`',
        },
        <String, dynamic>{
          'name': 'validity',
          'type': '`\$NUMBER`',
        },
      ],
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
              'parts': <dynamic>[
                'message',
                'flash',
              ],
              'select': <String, dynamic>{
                '\$action': 'flash',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/message/schedule',
              'parts': <dynamic>[
                'message',
                'schedule',
              ],
              'select': <String, dynamic>{
                '\$action': 'schedule',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/message/send',
              'parts': <dynamic>[
                'message',
                'send',
              ],
              'select': <String, dynamic>{
                '\$action': 'send',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/messages',
              'parts': <dynamic>[
                'messages',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/messages/failed',
              'parts': <dynamic>[
                'messages',
                'failed',
              ],
              'select': <String, dynamic>{
                '\$action': 'failed',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/messages/inbox',
              'parts': <dynamic>[
                'messages',
                'inbox',
              ],
              'select': <String, dynamic>{
                '\$action': 'inbox',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
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
              'parts': <dynamic>[
                'messages',
                '{id}',
              ],
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'messageid': 'id',
                },
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'GET',
              'orig': '/messages/schedule',
              'parts': <dynamic>[
                'messages',
                'schedule',
              ],
              'select': <String, dynamic>{
                '\$action': 'schedule',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
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
              'parts': <dynamic>[
                'messages',
                '{id}',
              ],
              'rename': <String, dynamic>{
                'param': <String, dynamic>{
                  'messageid': 'id',
                },
              },
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'id',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
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
              'parts': <dynamic>[
                'messages',
                'schedule',
                '{messageid}',
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
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'length',
          'type': '`\$OBJECT`',
        },
        <String, dynamic>{
          'name': 'metadata',
          'type': '`\$OBJECT`',
        },
        <String, dynamic>{
          'name': 'passcode',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'sender',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'template',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'validity',
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
              'parts': <dynamic>[
                'otp',
                'send',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/otp/verify',
              'parts': <dynamic>[
                'otp',
                'verify',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
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
              'parts': <dynamic>[
                'otp',
                '{messageid}',
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
              'parts': <dynamic>[
                'utils',
                'errors',
                '{errorcode}',
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
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'GET',
              'orig': '/utils/test',
              'parts': <dynamic>[
                'utils',
                'test',
              ],
              'select': <String, dynamic>{
                '\$action': 'test',
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
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
