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
    'name': 'ProjectName',
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
              'active': true,
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'param',
                    'name': 'id',
                    'orig': 'batchid',
                    'reqd': true,
                    'type': '`\$STRING`',
                    'index\$': 0,
                  },
                ],
              },
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
              'index\$': 0,
            },
          ],
          'key\$': 'load',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'batch_message': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'ai',
          'req': false,
          'type': '`\$BOOLEAN`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'content',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'deliveryreporturl',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'destination',
          'req': true,
          'type': '`\$ARRAY`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'schedule',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'sender',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'tag',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 6,
        },
        <String, dynamic>{
          'active': true,
          'name': 'ttl',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 7,
        },
        <String, dynamic>{
          'active': true,
          'name': 'validity',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 8,
        },
      ],
      'name': 'batch_message',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 2,
            },
          ],
          'key\$': 'create',
        },
        'remove': <String, dynamic>{
          'input': 'data',
          'name': 'remove',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'param',
                    'name': 'batchid',
                    'orig': 'batchid',
                    'reqd': true,
                    'type': '`\$STRING`',
                    'index\$': 0,
                  },
                ],
              },
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
              'index\$': 0,
            },
          ],
          'key\$': 'remove',
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
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
          ],
          'key\$': 'load',
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
          'active': true,
          'name': 'ai',
          'req': false,
          'type': '`\$BOOLEAN`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'content',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'credit',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'deliveryreporturl',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'destination',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': false,
              'type': '`\$STRING`',
            },
          },
          'req': true,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'from',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'keyword',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 6,
        },
        <String, dynamic>{
          'active': true,
          'name': 'limit',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 7,
        },
        <String, dynamic>{
          'active': true,
          'name': 'metadata',
          'req': false,
          'type': '`\$OBJECT`',
          'index\$': 8,
        },
        <String, dynamic>{
          'active': true,
          'name': 'responseemail',
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 9,
        },
        <String, dynamic>{
          'active': true,
          'name': 'schedule',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 10,
        },
        <String, dynamic>{
          'active': true,
          'name': 'sender',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': false,
              'type': '`\$STRING`',
            },
          },
          'req': true,
          'type': '`\$STRING`',
          'index\$': 11,
        },
        <String, dynamic>{
          'active': true,
          'name': 'skip',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 12,
        },
        <String, dynamic>{
          'active': true,
          'name': 'status',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 13,
        },
        <String, dynamic>{
          'active': true,
          'name': 'tag',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 14,
        },
        <String, dynamic>{
          'active': true,
          'name': 'to',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 15,
        },
        <String, dynamic>{
          'active': true,
          'name': 'ttl',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 16,
        },
        <String, dynamic>{
          'active': true,
          'name': 'unread',
          'req': false,
          'type': '`\$BOOLEAN`',
          'index\$': 17,
        },
        <String, dynamic>{
          'active': true,
          'name': 'validity',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 18,
        },
      ],
      'name': 'message',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 2,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 3,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 4,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 5,
            },
          ],
          'key\$': 'create',
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'param',
                    'name': 'id',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                    'index\$': 0,
                  },
                ],
              },
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
          ],
          'key\$': 'load',
        },
        'remove': <String, dynamic>{
          'input': 'data',
          'name': 'remove',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'param',
                    'name': 'id',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                    'index\$': 0,
                  },
                ],
              },
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'param',
                    'name': 'messageid',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                    'index\$': 0,
                  },
                ],
              },
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
              'index\$': 1,
            },
          ],
          'key\$': 'remove',
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
          'active': true,
          'name': 'destination',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'length',
          'req': false,
          'type': '`\$OBJECT`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'metadata',
          'req': false,
          'type': '`\$OBJECT`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'passcode',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'sender',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'template',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'validity',
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 6,
        },
      ],
      'name': 'one_time_password',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
          ],
          'key\$': 'create',
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'param',
                    'name': 'messageid',
                    'orig': 'messageid',
                    'reqd': true,
                    'type': '`\$STRING`',
                    'index\$': 0,
                  },
                ],
              },
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
              'index\$': 0,
            },
          ],
          'key\$': 'load',
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
              'active': true,
              'args': <String, dynamic>{
                'params': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'param',
                    'name': 'errorcode',
                    'orig': 'errorcode',
                    'reqd': true,
                    'type': '`\$STRING`',
                    'index\$': 0,
                  },
                ],
              },
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
          ],
          'key\$': 'load',
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
