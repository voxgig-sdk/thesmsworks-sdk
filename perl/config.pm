# Thesmsworks SDK configuration

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/lib/Voxgig/Struct.pm"));

package ThesmsworksConfig;

# GENERATED from the API model - do not edit by hand. Parsed fresh on
# each call so callers can safely mutate their copy.
my $CONFIG_JSON = <<'END_CONFIG_JSON';
{
  "main": {
    "name": "Thesmsworks",
    "slug": "thesmsworks",
    "version": "0.1.1",
    "target": "perl"
  },
  "feature": {
    "audit": {
      "options": {
        "active": false,
        "actor": "anonymous",
        "max": 1000
      },
      "optspec": {
        "now": "`$FUNCTION`",
        "sink": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
    "cache": {
      "options": {
        "active": false,
        "max": 256,
        "methods": [
          "GET"
        ],
        "ttl": 5000
      },
      "optspec": {
        "now": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
    "clienttrack": {
      "options": {
        "active": false,
        "clientVersion": "0.0.1"
      },
      "optspec": {
        "clientName": "`$STRING`",
        "clientVersion": "`$STRING`",
        "headers": "`$MAP`",
        "idgen": "`$FUNCTION`",
        "sessionId": "`$STRING`"
      },
      "strict": false,
      "transport": "none"
    },
    "cost": {
      "options": {
        "active": false,
        "budget": 0,
        "currency": "USD",
        "header": "",
        "onBudget": "warn",
        "path": "",
        "perUnit": 0,
        "rates": {},
        "unit": 0
      },
      "optspec": {
        "actor": "`$STRING`",
        "sink": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
    "debug": {
      "options": {
        "active": false,
        "max": 100,
        "redact": [
          "authorization",
          "cookie",
          "set-cookie",
          "api-key",
          "apikey",
          "x-api-key",
          "idempotency-key"
        ]
      },
      "optspec": {
        "now": "`$FUNCTION`",
        "onEntry": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
    "idempotency": {
      "options": {
        "active": false,
        "header": "Idempotency-Key",
        "methods": [
          "POST",
          "PUT",
          "PATCH",
          "DELETE"
        ],
        "ops": [
          "create",
          "update",
          "remove"
        ]
      },
      "optspec": {
        "keygen": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
    "log": {
      "options": {
        "active": true
      },
      "optspec": {
        "level": "`$STRING`",
        "logger": "`$ANY`"
      },
      "strict": false,
      "transport": "none"
    },
    "metrics": {
      "options": {
        "active": false
      },
      "optspec": {
        "now": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
    "netsim": {
      "options": {
        "active": false,
        "errorTimes": 0,
        "failEvery": 0,
        "failRate": 0,
        "failStatus": 503,
        "failTimes": 0,
        "latency": 0,
        "offline": false,
        "rateLimitTimes": 0,
        "retryAfter": 0,
        "seed": 1
      },
      "optspec": {
        "latency": [
          "`$ONE`",
          "`$NUMBER`",
          "`$MAP`"
        ],
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
    "paging": {
      "options": {
        "active": false,
        "afterVar": "after",
        "cursorParam": "cursor",
        "firstVar": "first",
        "limitParam": "limit",
        "pageParam": "page",
        "startPage": 1
      },
      "optspec": {
        "limit": "`$NUMBER`",
        "ops": "`$LIST`"
      },
      "strict": false,
      "transport": "none"
    },
    "proxy": {
      "options": {
        "active": false,
        "fromEnv": false,
        "noProxy": [],
        "url": ""
      },
      "optspec": {
        "agent": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
    "ratelimit": {
      "options": {
        "active": false,
        "burst": 5,
        "rate": 5
      },
      "optspec": {
        "now": "`$FUNCTION`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
    "rbac": {
      "options": {
        "active": false,
        "deny": false,
        "permissions": [],
        "rules": {}
      },
      "optspec": {},
      "strict": false,
      "transport": "none"
    },
    "retry": {
      "options": {
        "active": false,
        "factor": 2,
        "maxDelay": 2000,
        "minDelay": 50,
        "retries": 2,
        "statuses": [
          408,
          425,
          429,
          500,
          502,
          503,
          504
        ]
      },
      "optspec": {
        "jitter": "`$BOOLEAN`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
    "secrets": {
      "options": {
        "active": false,
        "cache": true,
        "exchange": {
          "active": false,
          "method": "POST",
          "path": "auth/token",
          "refresh": "",
          "request": "refresh_token",
          "response": "access_token",
          "retries": 1,
          "statuses": [
            401
          ]
        },
        "name": "apikey",
        "providers": []
      },
      "optspec": {},
      "strict": false,
      "transport": "wrap"
    },
    "streaming": {
      "options": {
        "active": false,
        "chunkDelay": 0,
        "chunkSize": 0
      },
      "optspec": {
        "ops": "`$LIST`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
    "telemetry": {
      "options": {
        "active": false
      },
      "optspec": {
        "exporter": "`$FUNCTION`",
        "headers": "`$MAP`",
        "idgen": "`$FUNCTION`",
        "now": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
    "test": {
      "options": {
        "active": false
      },
      "optspec": {
        "entity": "`$MAP`",
        "net": "`$MAP`"
      },
      "strict": false,
      "transport": "base"
    },
    "timeout": {
      "options": {
        "active": false,
        "ms": 30000
      },
      "optspec": {
        "clearTimer": "`$FUNCTION`",
        "setTimer": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
    "validate": {
      "options": {
        "active": false,
        "mode": "throw",
        "request": true,
        "response": false,
        "strict": false
      },
      "optspec": {
        "mode": [
          "`$ONE`",
          [
            "`$EXACT`",
            "throw"
          ],
          [
            "`$EXACT`",
            "report"
          ]
        ],
        "onInvalid": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    }
  },
  "options": {
    "base": "https://api.thesmsworks.co.uk/v1",
    "auth": {
      "prefix": ""
    },
    "headers": {
      "content-type": "application/json"
    },
    "entity": {
      "batch": {},
      "batch_message": {},
      "credit": {},
      "message": {},
      "one_time_password": {},
      "util": {}
    }
  },
  "entity": {
    "batch": {
      "fields": [
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "batch",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/batch/{batchid}",
              "segments": [
                {
                  "lit": "batch"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "batch",
                "{id}"
              ],
              "rename": {
                "param": {
                  "batchid": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "batchid",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
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
          "title": "Ai",
          "type": "`$BOOLEAN`",
          "short": "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary."
        },
        {
          "name": "content",
          "title": "Content",
          "type": "`$STRING`",
          "req": true,
          "short": "Message to send to the recipient"
        },
        {
          "name": "deliveryreporturl",
          "title": "Deliveryreporturl",
          "type": "`$STRING`",
          "short": "The url to which we should POST delivery reports to for this message."
        },
        {
          "name": "destinations",
          "title": "Destinations",
          "type": "`$ARRAY`",
          "req": true,
          "short": "Telephone numbers of each of the recipients"
        },
        {
          "name": "schedule",
          "title": "Schedule",
          "type": "`$STRING`",
          "short": "Date-time at which to send the batch."
        },
        {
          "name": "sender",
          "title": "Sender",
          "type": "`$STRING`",
          "req": true,
          "short": "The sender of the message."
        },
        {
          "name": "tag",
          "title": "Tag",
          "type": "`$STRING`",
          "short": "An identifying label for the message, which you can use to filter and report on messages you've sent later."
        },
        {
          "name": "ttl",
          "title": "Ttl",
          "type": "`$NUMBER`",
          "short": "The number of minutes before the delivery report is deleted."
        },
        {
          "name": "validity",
          "title": "Validity",
          "type": "`$NUMBER`",
          "short": "The optional number of minutes to attempt delivery before the message is marked as EXPIRED."
        }
      ],
      "name": "batch_message",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/batch/any",
              "segments": [
                {
                  "lit": "batch"
                },
                {
                  "lit": "any"
                }
              ],
              "parts": [
                "batch",
                "any"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/batch/schedule",
              "segments": [
                {
                  "lit": "batch"
                },
                {
                  "lit": "schedule"
                }
              ],
              "parts": [
                "batch",
                "schedule"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/batch/send",
              "segments": [
                {
                  "lit": "batch"
                },
                {
                  "lit": "send"
                }
              ],
              "parts": [
                "batch",
                "send"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/batches/schedule/{batchid}",
              "segments": [
                {
                  "lit": "batches"
                },
                {
                  "lit": "schedule"
                },
                {
                  "var": "batchid"
                }
              ],
              "parts": [
                "batches",
                "schedule",
                "{batchid}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "batchid",
                    "orig": "batchid",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "batchid"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
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
              "kind": "http",
              "method": "GET",
              "orig": "/credits/balance",
              "segments": [
                {
                  "lit": "credits"
                },
                {
                  "lit": "balance"
                }
              ],
              "parts": [
                "credits",
                "balance"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "balance"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "message": {
      "fields": [
        {
          "name": "credits",
          "title": "Credits",
          "type": "`$NUMBER`",
          "short": "The number of credits used on the message."
        },
        {
          "name": "destination",
          "title": "Destination",
          "type": "`$STRING`",
          "short": "The phone number of the recipient."
        },
        {
          "name": "from",
          "title": "From",
          "type": "`$STRING`",
          "short": "The date-time from which you would like matching messages"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        },
        {
          "name": "keyword",
          "title": "Keyword",
          "type": "`$STRING`",
          "short": "The keyword used in the inbound message"
        },
        {
          "name": "limit",
          "title": "Limit",
          "type": "`$NUMBER`",
          "short": "The maximum number of messages that you would like returned in this call."
        },
        {
          "name": "metadata",
          "title": "Metadata",
          "type": "`$OBJECT`",
          "short": "An array of objects containing metadata key/value pairs that have been saved on messages."
        },
        {
          "name": "sender",
          "title": "Sender",
          "type": "`$STRING`",
          "short": "The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message)."
        },
        {
          "name": "skip",
          "title": "Skip",
          "type": "`$NUMBER`",
          "short": "The number of results you would like to ignore before returning messages."
        },
        {
          "name": "status",
          "title": "Status",
          "type": "`$STRING`",
          "short": "The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')"
        },
        {
          "name": "to",
          "title": "To",
          "type": "`$STRING`",
          "short": "The date-time to which you would like matching messages"
        },
        {
          "name": "unread",
          "title": "Unread",
          "type": "`$BOOLEAN`",
          "short": "In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false)."
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "message",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/message/flash",
              "segments": [
                {
                  "lit": "message"
                },
                {
                  "lit": "flash"
                }
              ],
              "parts": [
                "message",
                "flash"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "flash"
              }
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/message/schedule",
              "segments": [
                {
                  "lit": "message"
                },
                {
                  "lit": "schedule"
                }
              ],
              "parts": [
                "message",
                "schedule"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "schedule"
              }
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/message/send",
              "segments": [
                {
                  "lit": "message"
                },
                {
                  "lit": "send"
                }
              ],
              "parts": [
                "message",
                "send"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "send"
              }
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/messages",
              "segments": [
                {
                  "lit": "messages"
                }
              ],
              "parts": [
                "messages"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/messages/failed",
              "segments": [
                {
                  "lit": "messages"
                },
                {
                  "lit": "failed"
                }
              ],
              "parts": [
                "messages",
                "failed"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "failed"
              }
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/messages/inbox",
              "segments": [
                {
                  "lit": "messages"
                },
                {
                  "lit": "inbox"
                }
              ],
              "parts": [
                "messages",
                "inbox"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "inbox"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/messages/{messageid}",
              "segments": [
                {
                  "lit": "messages"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "messages",
                "{id}"
              ],
              "rename": {
                "param": {
                  "messageid": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "messageid",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/messages/schedule",
              "segments": [
                {
                  "lit": "messages"
                },
                {
                  "lit": "schedule"
                }
              ],
              "parts": [
                "messages",
                "schedule"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "schedule"
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/messages/{messageid}",
              "segments": [
                {
                  "lit": "messages"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "messages",
                "{id}"
              ],
              "rename": {
                "param": {
                  "messageid": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "messageid",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/messages/schedule/{messageid}",
              "segments": [
                {
                  "lit": "messages"
                },
                {
                  "lit": "schedule"
                },
                {
                  "var": "messageid"
                }
              ],
              "parts": [
                "messages",
                "schedule",
                "{messageid}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "messageid",
                    "orig": "messageid",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "messageid"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "one_time_password": {
      "fields": [
        {
          "name": "destination",
          "title": "Destination",
          "type": "`$STRING`",
          "short": "The phone number of the recipient."
        },
        {
          "name": "length",
          "title": "Length",
          "type": "`$OBJECT`",
          "short": "The length of the generated passcode."
        },
        {
          "name": "metadata",
          "title": "Metadata",
          "type": "`$OBJECT`",
          "short": "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application."
        },
        {
          "name": "passcode",
          "title": "Passcode",
          "type": "`$STRING`",
          "short": "A passcode you supply for use in the message template."
        },
        {
          "name": "sender",
          "title": "Sender",
          "type": "`$STRING`",
          "short": "The sender of the message."
        },
        {
          "name": "template",
          "title": "Template",
          "type": "`$STRING`",
          "short": "A template to use as the content for the message."
        },
        {
          "name": "validity",
          "title": "Validity",
          "type": "`$NUMBER`",
          "short": "The length of time in seconds for which the generated passcode should be valid."
        }
      ],
      "name": "one_time_password",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/otp/send",
              "segments": [
                {
                  "lit": "otp"
                },
                {
                  "lit": "send"
                }
              ],
              "parts": [
                "otp",
                "send"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/otp/verify",
              "segments": [
                {
                  "lit": "otp"
                },
                {
                  "lit": "verify"
                }
              ],
              "parts": [
                "otp",
                "verify"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/otp/{messageid}",
              "segments": [
                {
                  "lit": "otp"
                },
                {
                  "var": "messageid"
                }
              ],
              "parts": [
                "otp",
                "{messageid}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "messageid",
                    "orig": "messageid",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "messageid"
                ]
              }
            }
          ]
        }
      },
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
              "kind": "http",
              "method": "GET",
              "orig": "/utils/errors/{errorcode}",
              "segments": [
                {
                  "lit": "utils"
                },
                {
                  "lit": "errors"
                },
                {
                  "var": "errorcode"
                }
              ],
              "parts": [
                "utils",
                "errors",
                "{errorcode}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "errorcode",
                    "orig": "errorcode",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "errorcode"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/utils/test",
              "segments": [
                {
                  "lit": "utils"
                },
                {
                  "lit": "test"
                }
              ],
              "parts": [
                "utils",
                "test"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "test"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}
END_CONFIG_JSON

sub make_config {
  return Voxgig::Struct::parse_json($CONFIG_JSON);
}

# SHARED CONFIG (sdkgen rung L2).
#
# The SDK reads the config on every request and never writes to it, so one
# instance is shared by every client rather than rebuilt per client - the
# difference between parsing the embedded JSON once and once per client.
#
# The returned structure is SHARED: treat it as read-only. Callers that need to
# mutate should use make_config, which always parses a fresh copy.
my $SHARED_CONFIG;

sub shared_config {
  $SHARED_CONFIG = make_config() unless defined $SHARED_CONFIG;
  return $SHARED_CONFIG;
}

sub make_feature {
  my ($name) = @_;
  require(Cwd::abs_path("$__dir/features.pm"));
  return ThesmsworksFeatures::make_feature($name);
}

1;
