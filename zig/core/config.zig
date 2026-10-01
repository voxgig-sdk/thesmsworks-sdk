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
            .{ "audit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "actor", h.vstr("anonymous") },
                    .{ "max", h.vnum(1000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sink", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "cache", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "max", h.vnum(256) },
                    .{ "methods", h.ja(&.{
                        h.vstr("GET"),
                    }) },
                    .{ "ttl", h.vnum(5000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "clienttrack", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "clientVersion", h.vstr("0.0.1") },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clientName", h.vstr("`$STRING`") },
                    .{ "clientVersion", h.vstr("`$STRING`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "sessionId", h.vstr("`$STRING`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "cost", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "budget", h.vnum(0) },
                    .{ "currency", h.vstr("USD") },
                    .{ "header", h.vstr("") },
                    .{ "onBudget", h.vstr("warn") },
                    .{ "path", h.vstr("") },
                    .{ "perUnit", h.vnum(0) },
                    .{ "rates", h.omap() },
                    .{ "unit", h.vnum(0) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "actor", h.vstr("`$STRING`") },
                    .{ "sink", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "debug", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "max", h.vnum(100) },
                    .{ "redact", h.ja(&.{
                        h.vstr("authorization"),
                        h.vstr("cookie"),
                        h.vstr("set-cookie"),
                        h.vstr("api-key"),
                        h.vstr("apikey"),
                        h.vstr("x-api-key"),
                        h.vstr("idempotency-key"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "onEntry", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "idempotency", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "header", h.vstr("Idempotency-Key") },
                    .{ "methods", h.ja(&.{
                        h.vstr("POST"),
                        h.vstr("PUT"),
                        h.vstr("PATCH"),
                        h.vstr("DELETE"),
                    }) },
                    .{ "ops", h.ja(&.{
                        h.vstr("create"),
                        h.vstr("update"),
                        h.vstr("remove"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "keygen", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "log", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(true) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "level", h.vstr("`$STRING`") },
                    .{ "logger", h.vstr("`$ANY`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "metrics", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "netsim", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "errorTimes", h.vnum(0) },
                    .{ "failEvery", h.vnum(0) },
                    .{ "failRate", h.vnum(0) },
                    .{ "failStatus", h.vnum(503) },
                    .{ "failTimes", h.vnum(0) },
                    .{ "latency", h.vnum(0) },
                    .{ "offline", h.vbool(false) },
                    .{ "rateLimitTimes", h.vnum(0) },
                    .{ "retryAfter", h.vnum(0) },
                    .{ "seed", h.vnum(1) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "latency", h.ja(&.{
                        h.vstr("`$ONE`"),
                        h.vstr("`$NUMBER`"),
                        h.vstr("`$MAP`"),
                    }) },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "paging", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "afterVar", h.vstr("after") },
                    .{ "cursorParam", h.vstr("cursor") },
                    .{ "firstVar", h.vstr("first") },
                    .{ "limitParam", h.vstr("limit") },
                    .{ "pageParam", h.vstr("page") },
                    .{ "startPage", h.vnum(1) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "limit", h.vstr("`$NUMBER`") },
                    .{ "ops", h.vstr("`$LIST`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "proxy", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "fromEnv", h.vbool(false) },
                    .{ "noProxy", h.olist() },
                    .{ "url", h.vstr("") },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "agent", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "ratelimit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "burst", h.vnum(5) },
                    .{ "rate", h.vnum(5) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "rbac", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "deny", h.vbool(false) },
                    .{ "permissions", h.olist() },
                    .{ "rules", h.omap() },
                }) },
                .{ "optspec", h.omap() },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "retry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "factor", h.vnum(2) },
                    .{ "maxDelay", h.vnum(2000) },
                    .{ "minDelay", h.vnum(50) },
                    .{ "retries", h.vnum(2) },
                    .{ "statuses", h.ja(&.{
                        h.vnum(408),
                        h.vnum(425),
                        h.vnum(429),
                        h.vnum(500),
                        h.vnum(502),
                        h.vnum(503),
                        h.vnum(504),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "jitter", h.vstr("`$BOOLEAN`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "secrets", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "cache", h.vbool(true) },
                    .{ "exchange", h.jo(&.{
                        .{ "active", h.vbool(false) },
                        .{ "method", h.vstr("POST") },
                        .{ "path", h.vstr("auth/token") },
                        .{ "refresh", h.vstr("") },
                        .{ "request", h.vstr("refresh_token") },
                        .{ "response", h.vstr("access_token") },
                        .{ "retries", h.vnum(1) },
                        .{ "statuses", h.ja(&.{
                            h.vnum(401),
                        }) },
                    }) },
                    .{ "name", h.vstr("apikey") },
                    .{ "providers", h.olist() },
                }) },
                .{ "optspec", h.omap() },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "streaming", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "chunkDelay", h.vnum(0) },
                    .{ "chunkSize", h.vnum(0) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "ops", h.vstr("`$LIST`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "telemetry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "exporter", h.vstr("`$FUNCTION`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "test", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "entity", h.vstr("`$MAP`") },
                    .{ "net", h.vstr("`$MAP`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("base") },
            }) },
            .{ "timeout", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "ms", h.vnum(30000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clearTimer", h.vstr("`$FUNCTION`") },
                    .{ "setTimer", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "validate", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "mode", h.vstr("throw") },
                    .{ "request", h.vbool(true) },
                    .{ "response", h.vbool(false) },
                    .{ "strict", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "mode", h.ja(&.{
                        h.vstr("`$ONE`"),
                        h.ja(&.{
                            h.vstr("`$EXACT`"),
                            h.vstr("throw"),
                        }),
                        h.ja(&.{
                            h.vstr("`$EXACT`"),
                            h.vstr("report"),
                        }),
                    }) },
                    .{ "onInvalid", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
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
                .{ "message", h.omap() },
                .{ "one_time_password", h.omap() },
                .{ "util", h.omap() },
            }) },
        }) },
        .{ "entity", h.jo(&.{
            .{ "batch", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("batch") },
                .{ "op", h.jo(&.{
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/batch/{batchid}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "batchid", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("batchid") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
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
                        .{ "title", h.vstr("Ai") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("content") },
                        .{ "title", h.vstr("Content") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Message to send to the recipient") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("deliveryreporturl") },
                        .{ "title", h.vstr("Deliveryreporturl") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The url to which we should POST delivery reports to for this message.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("destinations") },
                        .{ "title", h.vstr("Destinations") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Telephone numbers of each of the recipients") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("schedule") },
                        .{ "title", h.vstr("Schedule") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Date-time at which to send the batch.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "title", h.vstr("Sender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("The sender of the message.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("tag") },
                        .{ "title", h.vstr("Tag") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("An identifying label for the message, which you can use to filter and report on messages you've sent later.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("ttl") },
                        .{ "title", h.vstr("Ttl") },
                        .{ "type", h.vstr("`$NUMBER`") },
                        .{ "short", h.vstr("The number of minutes before the delivery report is deleted.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("validity") },
                        .{ "title", h.vstr("Validity") },
                        .{ "type", h.vstr("`$NUMBER`") },
                        .{ "short", h.vstr("The optional number of minutes to attempt delivery before the message is marked as EXPIRED.") },
                    }),
                }) },
                .{ "name", h.vstr("batch_message") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/batch/any") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("any") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("any"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/batch/schedule") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("schedule") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("schedule"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/batch/send") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batch") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("send") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batch"),
                                    h.vstr("send"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/batches/schedule/{batchid}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("batches") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("schedule") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("batchid") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("batches"),
                                    h.vstr("schedule"),
                                    h.vstr("{batchid}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("batchid") },
                                            .{ "orig", h.vstr("batchid") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("batchid"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
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
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/credits/balance") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("credits") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("balance") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("credits"),
                                    h.vstr("balance"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("balance") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "message", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("credits") },
                        .{ "title", h.vstr("Credits") },
                        .{ "type", h.vstr("`$NUMBER`") },
                        .{ "short", h.vstr("The number of credits used on the message.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("destination") },
                        .{ "title", h.vstr("Destination") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The phone number of the recipient.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("from") },
                        .{ "title", h.vstr("From") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The date-time from which you would like matching messages") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("keyword") },
                        .{ "title", h.vstr("Keyword") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The keyword used in the inbound message") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("limit") },
                        .{ "title", h.vstr("Limit") },
                        .{ "type", h.vstr("`$NUMBER`") },
                        .{ "short", h.vstr("The maximum number of messages that you would like returned in this call.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("metadata") },
                        .{ "title", h.vstr("Metadata") },
                        .{ "type", h.vstr("`$OBJECT`") },
                        .{ "short", h.vstr("An array of objects containing metadata key/value pairs that have been saved on messages.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "title", h.vstr("Sender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("skip") },
                        .{ "title", h.vstr("Skip") },
                        .{ "type", h.vstr("`$NUMBER`") },
                        .{ "short", h.vstr("The number of results you would like to ignore before returning messages.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("status") },
                        .{ "title", h.vstr("Status") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("to") },
                        .{ "title", h.vstr("To") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The date-time to which you would like matching messages") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("unread") },
                        .{ "title", h.vstr("Unread") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("message") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/message/flash") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("message") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("flash") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("message"),
                                    h.vstr("flash"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("flash") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/message/schedule") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("message") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("schedule") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("message"),
                                    h.vstr("schedule"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("schedule") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/message/send") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("message") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("send") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("message"),
                                    h.vstr("send"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("send") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/messages") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/messages/failed") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("failed") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("failed"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("failed") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/messages/inbox") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("inbox") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("inbox"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("inbox") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/messages/{messageid}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "messageid", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/messages/schedule") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("schedule") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("schedule"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("schedule") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/messages/{messageid}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "messageid", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/messages/schedule/{messageid}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("schedule") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("messageid") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("messages"),
                                    h.vstr("schedule"),
                                    h.vstr("{messageid}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("messageid") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("messageid"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "one_time_password", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("destination") },
                        .{ "title", h.vstr("Destination") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The phone number of the recipient.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("length") },
                        .{ "title", h.vstr("Length") },
                        .{ "type", h.vstr("`$OBJECT`") },
                        .{ "short", h.vstr("The length of the generated passcode.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("metadata") },
                        .{ "title", h.vstr("Metadata") },
                        .{ "type", h.vstr("`$OBJECT`") },
                        .{ "short", h.vstr("A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("passcode") },
                        .{ "title", h.vstr("Passcode") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("A passcode you supply for use in the message template.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "title", h.vstr("Sender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The sender of the message.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("template") },
                        .{ "title", h.vstr("Template") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("A template to use as the content for the message.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("validity") },
                        .{ "title", h.vstr("Validity") },
                        .{ "type", h.vstr("`$NUMBER`") },
                        .{ "short", h.vstr("The length of time in seconds for which the generated passcode should be valid.") },
                    }),
                }) },
                .{ "name", h.vstr("one_time_password") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/otp/send") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("otp") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("send") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("otp"),
                                    h.vstr("send"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/otp/verify") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("otp") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("verify") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("otp"),
                                    h.vstr("verify"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/otp/{messageid}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("otp") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("messageid") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("otp"),
                                    h.vstr("{messageid}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("messageid") },
                                            .{ "orig", h.vstr("messageid") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("messageid"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
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
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/utils/errors/{errorcode}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("utils") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("errors") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("errorcode") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("utils"),
                                    h.vstr("errors"),
                                    h.vstr("{errorcode}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("errorcode") },
                                            .{ "orig", h.vstr("errorcode") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("errorcode"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/utils/test") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("utils") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("test") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("utils"),
                                    h.vstr("test"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("test") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
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
    if (std.mem.eql(u8, name, "cost")) return @import("../feature/cost.zig").CostFeature.make();
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
    if (std.mem.eql(u8, name, "secrets")) return @import("../feature/secrets.zig").SecretsFeature.make();
    if (std.mem.eql(u8, name, "validate")) return @import("../feature/validate.zig").ValidateFeature.make();
    return @import("../feature/base.zig").BaseFeature.make();
}
