# Thesmsworks SDK configuration


# The sekreto plugin DEFINITIONS the model selected per feature, imported
# above by name from the modules the catalogue's active `plugin.def`
# entries declare. Handed to each feature (secrets builds its Sekreto
# with them): a provider kind not listed here is unknown to that SDK.
FEATURE_PLUGINS = {
}


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "Thesmsworks",
            "slug": "thesmsworks",
            "version": "0.0.2",
            "target": "py",
        },
        "feature": {
            "debug": {
        "options": {
          "active": False,
          "max": 100,
          "redact": [
            "authorization",
            "cookie",
            "set-cookie",
            "api-key",
            "apikey",
            "x-api-key",
            "idempotency-key",
          ],
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "onEntry": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "idempotency": {
        "options": {
          "active": False,
          "header": "Idempotency-Key",
          "methods": [
            "POST",
            "PUT",
            "PATCH",
            "DELETE",
          ],
          "ops": [
            "create",
            "update",
            "remove",
          ],
        },
        "optspec": {
          "keygen": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "metrics": {
        "options": {
          "active": False,
        },
        "optspec": {
          "now": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "paging": {
        "options": {
          "active": False,
          "afterVar": "after",
          "cursorParam": "cursor",
          "firstVar": "first",
          "limitParam": "limit",
          "pageParam": "page",
          "startPage": 1,
        },
        "optspec": {
          "limit": "`$NUMBER`",
          "ops": "`$LIST`",
        },
        "strict": False,
        "transport": "none",
      },
            "ratelimit": {
        "options": {
          "active": False,
          "burst": 5,
          "rate": 5,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "retry": {
        "options": {
          "active": False,
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
            504,
          ],
        },
        "optspec": {
          "jitter": "`$BOOLEAN`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "test": {
        "options": {
          "active": False,
        },
        "optspec": {
          "entity": "`$MAP`",
          "net": "`$MAP`",
        },
        "strict": False,
        "transport": "base",
      },
            "timeout": {
        "options": {
          "active": False,
          "ms": 30000,
        },
        "optspec": {
          "clearTimer": "`$FUNCTION`",
          "setTimer": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
        },
        "options": {
            "base": "https://api.thesmsworks.co.uk/v1",
            "auth": {
                "prefix": "",
            },
            "headers": {
        "content-type": "application/json",
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
                "util": {},
            },
        },
        "entity": {
      "batch": {
        "fields": [
          {
            "name": "id",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
        },
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
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/batch/{batchid}",
                "rename": {
                  "param": {
                    "batchid": "id",
                  },
                },
                "segments": [
                  {
                    "lit": "batch",
                  },
                  {
                    "var": "id",
                  },
                ],
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "batch",
                  "{id}",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "batch_message": {
        "fields": [
          {
            "name": "ai",
            "short": "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "content",
            "req": True,
            "short": "Message to send to the recipient",
            "type": "`$STRING`",
          },
          {
            "name": "deliveryreporturl",
            "short": "The url to which we should POST delivery reports to for this message.",
            "type": "`$STRING`",
          },
          {
            "name": "destinations",
            "req": True,
            "short": "Telephone numbers of each of the recipients",
            "type": "`$ARRAY`",
          },
          {
            "name": "schedule",
            "short": "Date-time at which to send the batch.",
            "type": "`$STRING`",
          },
          {
            "name": "sender",
            "req": True,
            "short": "The sender of the message.",
            "type": "`$STRING`",
          },
          {
            "name": "tag",
            "short": "An identifying label for the message, which you can use to filter and report on messages you've sent later.",
            "type": "`$STRING`",
          },
          {
            "name": "ttl",
            "short": "The number of minutes before the delivery report is deleted.",
            "type": "`$NUMBER`",
          },
          {
            "name": "validity",
            "short": "The optional number of minutes to attempt delivery before the message is marked as EXPIRED.",
            "type": "`$NUMBER`",
          },
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
                "segments": [
                  {
                    "lit": "batch",
                  },
                  {
                    "lit": "any",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "batch",
                  "any",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/batch/schedule",
                "segments": [
                  {
                    "lit": "batch",
                  },
                  {
                    "lit": "schedule",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "batch",
                  "schedule",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/batch/send",
                "segments": [
                  {
                    "lit": "batch",
                  },
                  {
                    "lit": "send",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "batch",
                  "send",
                ],
              },
            ],
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
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "DELETE",
                "orig": "/batches/schedule/{batchid}",
                "segments": [
                  {
                    "lit": "batches",
                  },
                  {
                    "lit": "schedule",
                  },
                  {
                    "var": "batchid",
                  },
                ],
                "select": {
                  "exist": [
                    "batchid",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "batches",
                  "schedule",
                  "{batchid}",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "schedule",
            ],
          ],
        },
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
                "segments": [
                  {
                    "lit": "credits",
                  },
                  {
                    "lit": "balance",
                  },
                ],
                "select": {
                  "$action": "balance",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "credits",
                  "balance",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "flash": {
        "fields": [],
        "name": "flash",
        "op": {},
        "relations": {
          "ancestors": [],
        },
      },
      "message": {
        "fields": [
          {
            "name": "credits",
            "short": "The number of credits used on the message.",
            "type": "`$NUMBER`",
          },
          {
            "name": "destination",
            "short": "The phone number of the recipient.",
            "type": "`$STRING`",
          },
          {
            "name": "from",
            "short": "The date-time from which you would like matching messages",
            "type": "`$STRING`",
          },
          {
            "name": "id",
            "type": "`$STRING`",
          },
          {
            "name": "keyword",
            "short": "The keyword used in the inbound message",
            "type": "`$STRING`",
          },
          {
            "name": "limit",
            "short": "The maximum number of messages that you would like returned in this call.",
            "type": "`$NUMBER`",
          },
          {
            "name": "metadata",
            "short": "An array of objects containing metadata key/value pairs that have been saved on messages.",
            "type": "`$OBJECT`",
          },
          {
            "name": "sender",
            "short": "The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).",
            "type": "`$STRING`",
          },
          {
            "name": "skip",
            "short": "The number of results you would like to ignore before returning messages.",
            "type": "`$NUMBER`",
          },
          {
            "name": "status",
            "short": "The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')",
            "type": "`$STRING`",
          },
          {
            "name": "to",
            "short": "The date-time to which you would like matching messages",
            "type": "`$STRING`",
          },
          {
            "name": "unread",
            "short": "In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).",
            "type": "`$BOOLEAN`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
        },
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
                "segments": [
                  {
                    "lit": "message",
                  },
                  {
                    "lit": "flash",
                  },
                ],
                "select": {
                  "$action": "flash",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "message",
                  "flash",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/message/schedule",
                "segments": [
                  {
                    "lit": "message",
                  },
                  {
                    "lit": "schedule",
                  },
                ],
                "select": {
                  "$action": "schedule",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "message",
                  "schedule",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/message/send",
                "segments": [
                  {
                    "lit": "message",
                  },
                  {
                    "lit": "send",
                  },
                ],
                "select": {
                  "$action": "send",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "message",
                  "send",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/messages",
                "segments": [
                  {
                    "lit": "messages",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "messages",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/messages/failed",
                "segments": [
                  {
                    "lit": "messages",
                  },
                  {
                    "lit": "failed",
                  },
                ],
                "select": {
                  "$action": "failed",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "messages",
                  "failed",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/messages/inbox",
                "segments": [
                  {
                    "lit": "messages",
                  },
                  {
                    "lit": "inbox",
                  },
                ],
                "select": {
                  "$action": "inbox",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "messages",
                  "inbox",
                ],
              },
            ],
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
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/messages/{messageid}",
                "rename": {
                  "param": {
                    "messageid": "id",
                  },
                },
                "segments": [
                  {
                    "lit": "messages",
                  },
                  {
                    "var": "id",
                  },
                ],
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "messages",
                  "{id}",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/messages/schedule",
                "segments": [
                  {
                    "lit": "messages",
                  },
                  {
                    "lit": "schedule",
                  },
                ],
                "select": {
                  "$action": "schedule",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "messages",
                  "schedule",
                ],
              },
            ],
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
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "DELETE",
                "orig": "/messages/{messageid}",
                "rename": {
                  "param": {
                    "messageid": "id",
                  },
                },
                "segments": [
                  {
                    "lit": "messages",
                  },
                  {
                    "var": "id",
                  },
                ],
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "messages",
                  "{id}",
                ],
              },
              {
                "args": {
                  "params": [
                    {
                      "kind": "param",
                      "name": "messageid",
                      "orig": "messageid",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "DELETE",
                "orig": "/messages/schedule/{messageid}",
                "segments": [
                  {
                    "lit": "messages",
                  },
                  {
                    "lit": "schedule",
                  },
                  {
                    "var": "messageid",
                  },
                ],
                "select": {
                  "exist": [
                    "messageid",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "messages",
                  "schedule",
                  "{messageid}",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "schedule",
            ],
          ],
        },
      },
      "one_time_password": {
        "fields": [
          {
            "name": "destination",
            "short": "The phone number of the recipient.",
            "type": "`$STRING`",
          },
          {
            "name": "length",
            "short": "The length of the generated passcode.",
            "type": "`$OBJECT`",
          },
          {
            "name": "metadata",
            "short": "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.",
            "type": "`$OBJECT`",
          },
          {
            "name": "passcode",
            "short": "A passcode you supply for use in the message template.",
            "type": "`$STRING`",
          },
          {
            "name": "sender",
            "short": "The sender of the message.",
            "type": "`$STRING`",
          },
          {
            "name": "template",
            "short": "A template to use as the content for the message.",
            "type": "`$STRING`",
          },
          {
            "name": "validity",
            "short": "The length of time in seconds for which the generated passcode should be valid.",
            "type": "`$NUMBER`",
          },
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
                "segments": [
                  {
                    "lit": "otp",
                  },
                  {
                    "lit": "send",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "otp",
                  "send",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/otp/verify",
                "segments": [
                  {
                    "lit": "otp",
                  },
                  {
                    "lit": "verify",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "otp",
                  "verify",
                ],
              },
            ],
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
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/otp/{messageid}",
                "segments": [
                  {
                    "lit": "otp",
                  },
                  {
                    "var": "messageid",
                  },
                ],
                "select": {
                  "exist": [
                    "messageid",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "otp",
                  "{messageid}",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "otp",
            ],
          ],
        },
      },
      "schedule": {
        "fields": [],
        "name": "schedule",
        "op": {},
        "relations": {
          "ancestors": [],
        },
      },
      "swagger": {
        "fields": [],
        "name": "swagger",
        "op": {},
        "relations": {
          "ancestors": [],
        },
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
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/utils/errors/{errorcode}",
                "segments": [
                  {
                    "lit": "utils",
                  },
                  {
                    "lit": "errors",
                  },
                  {
                    "var": "errorcode",
                  },
                ],
                "select": {
                  "exist": [
                    "errorcode",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "utils",
                  "errors",
                  "{errorcode}",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/utils/test",
                "segments": [
                  {
                    "lit": "utils",
                  },
                  {
                    "lit": "test",
                  },
                ],
                "select": {
                  "$action": "test",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "utils",
                  "test",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "error",
            ],
          ],
        },
      },
    },
    }
