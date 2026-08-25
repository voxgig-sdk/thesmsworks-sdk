// Generated API configuration (mirrors go/rust core/config).

const std = @import("std");
const h = @import("helpers.zig");
const types = @import("types.zig");
const Value = h.Value;
const Feature = types.Feature;

pub fn make_config() Value {
    return h.jo(&.{
        .{ "main", h.jo(&.{
            .{ "name", h.vstr("Thesmsworks") },
            .{ "slug", h.vstr("thesmsworks") },
            .{ "version", h.vstr("0.1.1") },
            .{ "target", h.vstr("zig") },
        }) },
        .{ "feature", h.jo(&.{
            .{ "test", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "transport", h.vstr("base") },
            }) },
        }) },
        .{ "options", h.jo(&.{
            .{ "base", h.vstr("https://api.thesmsworks.co.uk/v1") },
            .{ "auth", h.jo(&.{
                .{ "prefix", h.vstr("") },
            }) },
            .{ "headers", h.jo(&.{
                .{ "content-type", h.vstr("application/json") },
            }) },
            .{ "entity", h.jo(&.{
                .{ "batch", h.omap() },
                .{ "batch_message", h.omap() },
                .{ "credit", h.omap() },
                .{ "flash", h.omap() },
                .{ "message", h.omap() },
                .{ "one_time_password", h.omap() },
                .{ "schedule", h.omap() },
                .{ "swagger", h.omap() },
                .{ "util", h.omap() },
            }) },
        }) },
        .{ "entity", h.jo(&.{
            .{ "batch", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("batch") },
                .{ "op", h.jo(&.{
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "kind", h.vstr("param") },
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("batchid") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "type", h.vstr("`$STRING`") },
                                        }),
                                    }) },
                                }) },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/batch/{batchid}") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "batchid", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "batch_message", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("ai") },
                        .{ "short", h.vstr("Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("content") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Message to send to the recipient") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("deliveryreporturl") },
                        .{ "short", h.vstr("The url to which we should POST delivery reports to for this message.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("destinations") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Telephone numbers of each of the recipients") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("schedule") },
                        .{ "short", h.vstr("Date-time at which to send the batch.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("The sender of the message.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("tag") },
                        .{ "short", h.vstr("An identifying label for the message, which you can use to filter and report on messages you've sent later.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("ttl") },
                        .{ "short", h.vstr("The number of minutes before the delivery report is deleted.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("validity") },
                        .{ "short", h.vstr("The optional number of minutes to attempt delivery before the message is marked as EXPIRED.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                }) },
                .{ "name", h.vstr("batch_message") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/batch/any") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("any"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/batch/schedule") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("schedule"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/batch/send") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("send"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "kind", h.vstr("param") },
                                            .{ "name", h.vstr("batchid") },
                                            .{ "orig", h.vstr("batchid") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "type", h.vstr("`$STRING`") },
                                        }),
                                    }) },
                                }) },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/batches/schedule/{batchid}") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batches"),
                                    h.vstr("schedule"),
                                    h.vstr("{batchid}"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("batchid"),
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("schedule"),
                        }),
                    }) },
                }) },
            }) },
            .{ "credit", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("credit") },
                .{ "op", h.jo(&.{
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/credits/balance") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("credits"),
                                    h.vstr("balance"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("balance") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "flash", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("flash") },
                .{ "op", h.omap() },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "message", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("ai") },
                        .{ "short", h.vstr("Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("content") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Message to send to the recipient.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("credits") },
                        .{ "short", h.vstr("The number of credits used on the message.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("deliveryreporturl") },
                        .{ "short", h.vstr("The url to which we should POST delivery reports to for this message.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("destination") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Telephone number of the recipient") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("from") },
                        .{ "short", h.vstr("The date-time from which you would like matching messages") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("keyword") },
                        .{ "short", h.vstr("The keyword used in the inbound message") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("limit") },
                        .{ "short", h.vstr("The maximum number of messages that you would like returned in this call.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("metadata") },
                        .{ "short", h.vstr("An array of objects containing metadata key/value pairs that have been saved on messages.") },
                        .{ "type", h.vstr("`$OBJECT`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("responseemail") },
                        .{ "short", h.vstr("An optional list of email addresses to forward responses to this specific message to.") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("schedule") },
                        .{ "short", h.vstr("Date at which to send the message.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "op", h.jo(&.{
                            .{ "create", h.jo(&.{
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("The sender of the message.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("skip") },
                        .{ "short", h.vstr("The number of results you would like to ignore before returning messages.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("status") },
                        .{ "short", h.vstr("The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("tag") },
                        .{ "short", h.vstr("An identifying label for the message, which you can use to filter and report on messages you've sent later.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("to") },
                        .{ "short", h.vstr("The date-time to which you would like matching messages") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("ttl") },
                        .{ "short", h.vstr("The optional number of minutes before the delivery report is deleted.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("unread") },
                        .{ "short", h.vstr("In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("validity") },
                        .{ "short", h.vstr("The optional number of minutes to attempt delivery before the message is marked as EXPIRED.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                }) },
                .{ "name", h.vstr("message") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/message/flash") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("message"),
                                    h.vstr("flash"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("flash") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/message/schedule") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("message"),
                                    h.vstr("schedule"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("schedule") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/message/send") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("message"),
                                    h.vstr("send"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("send") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/messages") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/messages/failed") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("failed"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("failed") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/messages/inbox") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("inbox"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("inbox") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "kind", h.vstr("param") },
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "type", h.vstr("`$STRING`") },
                                        }),
                                    }) },
                                }) },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/messages/{messageid}") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "messageid", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/messages/schedule") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("schedule"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("schedule") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "kind", h.vstr("param") },
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "type", h.vstr("`$STRING`") },
                                        }),
                                    }) },
                                }) },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/messages/{messageid}") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "messageid", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "kind", h.vstr("param") },
                                            .{ "name", h.vstr("messageid") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "type", h.vstr("`$STRING`") },
                                        }),
                                    }) },
                                }) },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/messages/schedule/{messageid}") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("schedule"),
                                    h.vstr("{messageid}"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("messageid"),
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("schedule"),
                        }),
                    }) },
                }) },
            }) },
            .{ "one_time_password", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("destination") },
                        .{ "short", h.vstr("The phone number of the recipient.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("length") },
                        .{ "short", h.vstr("The length of the generated passcode.") },
                        .{ "type", h.vstr("`$OBJECT`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("metadata") },
                        .{ "short", h.vstr("A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.") },
                        .{ "type", h.vstr("`$OBJECT`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("passcode") },
                        .{ "short", h.vstr("A passcode you supply for use in the message template.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "short", h.vstr("The sender of the message.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("template") },
                        .{ "short", h.vstr("A template to use as the content for the message.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("validity") },
                        .{ "short", h.vstr("The length of time in seconds for which the generated passcode should be valid.") },
                        .{ "type", h.vstr("`$NUMBER`") },
                    }),
                }) },
                .{ "name", h.vstr("one_time_password") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/otp/send") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("otp"),
                                    h.vstr("send"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/otp/verify") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("otp"),
                                    h.vstr("verify"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "kind", h.vstr("param") },
                                            .{ "name", h.vstr("messageid") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "type", h.vstr("`$STRING`") },
                                        }),
                                    }) },
                                }) },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/otp/{messageid}") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("otp"),
                                    h.vstr("{messageid}"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("messageid"),
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("otp"),
                        }),
                    }) },
                }) },
            }) },
            .{ "schedule", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("schedule") },
                .{ "op", h.omap() },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "swagger", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("swagger") },
                .{ "op", h.omap() },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "util", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("util") },
                .{ "op", h.jo(&.{
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "kind", h.vstr("param") },
                                            .{ "name", h.vstr("errorcode") },
                                            .{ "orig", h.vstr("errorcode") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "type", h.vstr("`$STRING`") },
                                        }),
                                    }) },
                                }) },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/utils/errors/{errorcode}") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("utils"),
                                    h.vstr("errors"),
                                    h.vstr("{errorcode}"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("errorcode"),
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/utils/test") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("utils"),
                                    h.vstr("test"),
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("test") },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("error"),
                        }),
                    }) },
                }) },
            }) },
        }) },
    });
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// Value nodes are arena-allocated and reference-stable, so the shared value is
// genuinely one structure, not a copy.
var shared_config_val: ?Value = null;

/// The process-wide config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() Value {
    if (shared_config_val) |c| return c;
    const c = make_config();
    shared_config_val = c;
    return c;
}

pub fn make_feature(name: []const u8) Feature {
    if (std.mem.eql(u8, name, "audit")) return @import("../feature/audit.zig").AuditFeature.make();
    if (std.mem.eql(u8, name, "cache")) return @import("../feature/cache.zig").CacheFeature.make();
    if (std.mem.eql(u8, name, "clienttrack")) return @import("../feature/clienttrack.zig").ClienttrackFeature.make();
    if (std.mem.eql(u8, name, "debug")) return @import("../feature/debug.zig").DebugFeature.make();
    if (std.mem.eql(u8, name, "idempotency")) return @import("../feature/idempotency.zig").IdempotencyFeature.make();
    if (std.mem.eql(u8, name, "log")) return @import("../feature/log.zig").LogFeature.make();
    if (std.mem.eql(u8, name, "metrics")) return @import("../feature/metrics.zig").MetricsFeature.make();
    if (std.mem.eql(u8, name, "netsim")) return @import("../feature/netsim.zig").NetsimFeature.make();
    if (std.mem.eql(u8, name, "paging")) return @import("../feature/paging.zig").PagingFeature.make();
    if (std.mem.eql(u8, name, "proxy")) return @import("../feature/proxy.zig").ProxyFeature.make();
    if (std.mem.eql(u8, name, "ratelimit")) return @import("../feature/ratelimit.zig").RatelimitFeature.make();
    if (std.mem.eql(u8, name, "rbac")) return @import("../feature/rbac.zig").RbacFeature.make();
    if (std.mem.eql(u8, name, "retry")) return @import("../feature/retry.zig").RetryFeature.make();
    if (std.mem.eql(u8, name, "streaming")) return @import("../feature/streaming.zig").StreamingFeature.make();
    if (std.mem.eql(u8, name, "telemetry")) return @import("../feature/telemetry.zig").TelemetryFeature.make();
    if (std.mem.eql(u8, name, "test")) return @import("../feature/test.zig").TestFeature.make();
    if (std.mem.eql(u8, name, "timeout")) return @import("../feature/timeout.zig").TimeoutFeature.make();
    return @import("../feature/base.zig").BaseFeature.make();
}
