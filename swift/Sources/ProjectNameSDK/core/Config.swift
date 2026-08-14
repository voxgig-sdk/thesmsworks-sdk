// Thesmsworks SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

import Foundation

public enum SdkConfig {
  public static func makeConfig() -> VMap {
    let json = #"""
{
  "main": {
    "name": "Thesmsworks"
  },
  "feature": {
    "test": {
      "options": {
        "active": false
      }
    }
  },
  "options": {
    "base": "https://api.thesmsworks.co.uk/v1",
    "headers": {
      "content-type": "application/json"
    },
    "entity": {
      "batch": {},
      "batch_message": {},
      "credit": {},
      "flash": {},
      "message": {},
      "one_time_password": {},
      "schedule": {},
      "swagger": {},
      "util": {}
    },
    "auth": {
      "prefix": ""
    }
  },
  "entity": {
    "batch": {
      "fields": [],
      "name": "batch",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "id",
                    "orig": "batchid",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/batch/{batchid}",
              "parts": [
                "batch",
                "{id}"
              ],
              "rename": {
                "param": {
                  "batchid": "id"
                }
              },
              "select": {
                "exist": [
                  "id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "batch_message": {
      "fields": [
        {
          "name": "ai",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "content",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "deliveryreporturl",
          "type": "`$STRING`"
        },
        {
          "name": "destinations",
          "req": true,
          "type": "`$ARRAY`"
        },
        {
          "name": "schedule",
          "type": "`$STRING`"
        },
        {
          "name": "sender",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "tag",
          "type": "`$STRING`"
        },
        {
          "name": "ttl",
          "type": "`$NUMBER`"
        },
        {
          "name": "validity",
          "type": "`$NUMBER`"
        }
      ],
      "name": "batch_message",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/batch/any",
              "parts": [
                "batch",
                "any"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/batch/schedule",
              "parts": [
                "batch",
                "schedule"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/batch/send",
              "parts": [
                "batch",
                "send"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "batchid",
                    "orig": "batchid",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "DELETE",
              "orig": "/batches/schedule/{batchid}",
              "parts": [
                "batches",
                "schedule",
                "{batchid}"
              ],
              "select": {
                "exist": [
                  "batchid"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "schedule"
          ]
        ]
      }
    },
    "credit": {
      "fields": [],
      "name": "credit",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "GET",
              "orig": "/credits/balance",
              "parts": [
                "credits",
                "balance"
              ],
              "select": {
                "$action": "balance"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "flash": {
      "fields": [],
      "name": "flash",
      "op": {},
      "relations": {
        "ancestors": []
      }
    },
    "message": {
      "fields": [
        {
          "name": "ai",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "content",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "credits",
          "type": "`$NUMBER`"
        },
        {
          "name": "deliveryreporturl",
          "type": "`$STRING`"
        },
        {
          "name": "destination",
          "op": {
            "create": {
              "type": "`$STRING`"
            }
          },
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "from",
          "type": "`$STRING`"
        },
        {
          "name": "keyword",
          "type": "`$STRING`"
        },
        {
          "name": "limit",
          "type": "`$NUMBER`"
        },
        {
          "name": "metadata",
          "type": "`$OBJECT`"
        },
        {
          "name": "responseemail",
          "type": "`$ARRAY`"
        },
        {
          "name": "schedule",
          "type": "`$STRING`"
        },
        {
          "name": "sender",
          "op": {
            "create": {
              "type": "`$STRING`"
            }
          },
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "skip",
          "type": "`$NUMBER`"
        },
        {
          "name": "status",
          "type": "`$STRING`"
        },
        {
          "name": "tag",
          "type": "`$STRING`"
        },
        {
          "name": "to",
          "type": "`$STRING`"
        },
        {
          "name": "ttl",
          "type": "`$NUMBER`"
        },
        {
          "name": "unread",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "validity",
          "type": "`$NUMBER`"
        }
      ],
      "name": "message",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/message/flash",
              "parts": [
                "message",
                "flash"
              ],
              "select": {
                "$action": "flash"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/message/schedule",
              "parts": [
                "message",
                "schedule"
              ],
              "select": {
                "$action": "schedule"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/message/send",
              "parts": [
                "message",
                "send"
              ],
              "select": {
                "$action": "send"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/messages",
              "parts": [
                "messages"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/messages/failed",
              "parts": [
                "messages",
                "failed"
              ],
              "select": {
                "$action": "failed"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/messages/inbox",
              "parts": [
                "messages",
                "inbox"
              ],
              "select": {
                "$action": "inbox"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "id",
                    "orig": "messageid",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/messages/{messageid}",
              "parts": [
                "messages",
                "{id}"
              ],
              "rename": {
                "param": {
                  "messageid": "id"
                }
              },
              "select": {
                "exist": [
                  "id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "GET",
              "orig": "/messages/schedule",
              "parts": [
                "messages",
                "schedule"
              ],
              "select": {
                "$action": "schedule"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "id",
                    "orig": "messageid",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "DELETE",
              "orig": "/messages/{messageid}",
              "parts": [
                "messages",
                "{id}"
              ],
              "rename": {
                "param": {
                  "messageid": "id"
                }
              },
              "select": {
                "exist": [
                  "id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "messageid",
                    "orig": "messageid",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "DELETE",
              "orig": "/messages/schedule/{messageid}",
              "parts": [
                "messages",
                "schedule",
                "{messageid}"
              ],
              "select": {
                "exist": [
                  "messageid"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "schedule"
          ]
        ]
      }
    },
    "one_time_password": {
      "fields": [
        {
          "name": "destination",
          "type": "`$STRING`"
        },
        {
          "name": "length",
          "type": "`$OBJECT`"
        },
        {
          "name": "metadata",
          "type": "`$OBJECT`"
        },
        {
          "name": "passcode",
          "type": "`$STRING`"
        },
        {
          "name": "sender",
          "type": "`$STRING`"
        },
        {
          "name": "template",
          "type": "`$STRING`"
        },
        {
          "name": "validity",
          "type": "`$NUMBER`"
        }
      ],
      "name": "one_time_password",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/otp/send",
              "parts": [
                "otp",
                "send"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/otp/verify",
              "parts": [
                "otp",
                "verify"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "messageid",
                    "orig": "messageid",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/otp/{messageid}",
              "parts": [
                "otp",
                "{messageid}"
              ],
              "select": {
                "exist": [
                  "messageid"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "otp"
          ]
        ]
      }
    },
    "schedule": {
      "fields": [],
      "name": "schedule",
      "op": {},
      "relations": {
        "ancestors": []
      }
    },
    "swagger": {
      "fields": [],
      "name": "swagger",
      "op": {},
      "relations": {
        "ancestors": []
      }
    },
    "util": {
      "fields": [],
      "name": "util",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "errorcode",
                    "orig": "errorcode",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/utils/errors/{errorcode}",
              "parts": [
                "utils",
                "errors",
                "{errorcode}"
              ],
              "select": {
                "exist": [
                  "errorcode"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "GET",
              "orig": "/utils/test",
              "parts": [
                "utils",
                "test"
              ],
              "select": {
                "$action": "test"
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "error"
          ]
        ]
      }
    }
  }
}
"""#
    return (try? JSON.parse(json))?.asMap ?? VMap()
  }

  public static func makeFeature(_ name: String) -> BaseFeature {
    switch name {
    case "test": return TestFeature()
    default: return BaseFeature()
    }
  }
}
