// Generated API configuration (mirrors go core/config.go).

use std::cell::RefCell;
use std::rc::Rc;

use crate::core::types::FeatureRef;
use crate::utility::voxgigstruct::Value;

pub fn make_config() -> Value {
    Value::map_of([
        ("main".to_string(), Value::map_of([
            ("name".to_string(), Value::str("Thesmsworks")),
            ("slug".to_string(), Value::str("thesmsworks")),
            ("version".to_string(), Value::str("0.0.2")),
            ("target".to_string(), Value::str("rust")),
        ])),
        ("feature".to_string(), Value::map_of([
            ("debug".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("max".to_string(), Value::Num(100f64)),
                    ("redact".to_string(), Value::list(vec![
                        Value::str("authorization"),
                        Value::str("cookie"),
                        Value::str("set-cookie"),
                        Value::str("api-key"),
                        Value::str("apikey"),
                        Value::str("x-api-key"),
                        Value::str("idempotency-key"),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("onEntry".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("idempotency".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("header".to_string(), Value::str("Idempotency-Key")),
                    ("methods".to_string(), Value::list(vec![
                        Value::str("POST"),
                        Value::str("PUT"),
                        Value::str("PATCH"),
                        Value::str("DELETE"),
                    ])),
                    ("ops".to_string(), Value::list(vec![
                        Value::str("create"),
                        Value::str("update"),
                        Value::str("remove"),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("keygen".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("metrics".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("paging".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("afterVar".to_string(), Value::str("after")),
                    ("cursorParam".to_string(), Value::str("cursor")),
                    ("firstVar".to_string(), Value::str("first")),
                    ("limitParam".to_string(), Value::str("limit")),
                    ("pageParam".to_string(), Value::str("page")),
                    ("startPage".to_string(), Value::Num(1f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("limit".to_string(), Value::str("`$NUMBER`")),
                    ("ops".to_string(), Value::str("`$LIST`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("ratelimit".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("burst".to_string(), Value::Num(5f64)),
                    ("rate".to_string(), Value::Num(5f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("retry".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("factor".to_string(), Value::Num(2f64)),
                    ("maxDelay".to_string(), Value::Num(2000f64)),
                    ("minDelay".to_string(), Value::Num(50f64)),
                    ("retries".to_string(), Value::Num(2f64)),
                    ("statuses".to_string(), Value::list(vec![
                        Value::Num(408f64),
                        Value::Num(425f64),
                        Value::Num(429f64),
                        Value::Num(500f64),
                        Value::Num(502f64),
                        Value::Num(503f64),
                        Value::Num(504f64),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("jitter".to_string(), Value::str("`$BOOLEAN`")),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("test".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("entity".to_string(), Value::str("`$MAP`")),
                    ("net".to_string(), Value::str("`$MAP`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("base")),
            ])),
            ("timeout".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("ms".to_string(), Value::Num(30000f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("clearTimer".to_string(), Value::str("`$FUNCTION`")),
                    ("setTimer".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
        ])),
        ("options".to_string(), Value::map_of([
            ("base".to_string(), Value::str("https://api.thesmsworks.co.uk/v1")),
            ("auth".to_string(), Value::map_of([
                ("prefix".to_string(), Value::str("")),
            ])),
            ("headers".to_string(), Value::map_of([
                ("content-type".to_string(), Value::str("application/json")),
            ])),
            ("entity".to_string(), Value::map_of([
                ("batch".to_string(), Value::empty_map()),
                ("batch_message".to_string(), Value::empty_map()),
                ("credit".to_string(), Value::empty_map()),
                ("flash".to_string(), Value::empty_map()),
                ("message".to_string(), Value::empty_map()),
                ("one_time_password".to_string(), Value::empty_map()),
                ("schedule".to_string(), Value::empty_map()),
                ("swagger".to_string(), Value::empty_map()),
                ("util".to_string(), Value::empty_map()),
            ])),
        ])),
        ("entity".to_string(), Value::map_of([
            ("batch".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("batch")),
                ("op".to_string(), Value::map_of([
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("batchid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/batch/{batchid}")),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("batchid".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("batch")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("{id}"),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("batch_message".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("ai")),
                        ("short".to_string(), Value::str("Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("content")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Message to send to the recipient")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("deliveryreporturl")),
                        ("short".to_string(), Value::str("The url to which we should POST delivery reports to for this message.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("destinations")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Telephone numbers of each of the recipients")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("schedule")),
                        ("short".to_string(), Value::str("Date-time at which to send the batch.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("sender")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("The sender of the message.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("tag")),
                        ("short".to_string(), Value::str("An identifying label for the message, which you can use to filter and report on messages you've sent later.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("ttl")),
                        ("short".to_string(), Value::str("The number of minutes before the delivery report is deleted.")),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("validity")),
                        ("short".to_string(), Value::str("The optional number of minutes to attempt delivery before the message is marked as EXPIRED.")),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("batch_message")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/batch/any")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("batch")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("any")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("any"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/batch/schedule")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("batch")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("schedule")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("schedule"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/batch/send")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("batch")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("send")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("send"),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("batchid")),
                                            ("orig".to_string(), Value::str("batchid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/batches/schedule/{batchid}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("batches")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("schedule")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("batchid")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("batchid"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batches"),
                                    Value::str("schedule"),
                                    Value::str("{batchid}"),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("schedule"),
                        ]),
                    ])),
                ])),
            ])),
            ("credit".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("credit")),
                ("op".to_string(), Value::map_of([
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/credits/balance")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("credits")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("balance")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("balance")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("credits"),
                                    Value::str("balance"),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("flash".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("flash")),
                ("op".to_string(), Value::empty_map()),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("message".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("credits")),
                        ("short".to_string(), Value::str("The number of credits used on the message.")),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("destination")),
                        ("short".to_string(), Value::str("The phone number of the recipient.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("from")),
                        ("short".to_string(), Value::str("The date-time from which you would like matching messages")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("keyword")),
                        ("short".to_string(), Value::str("The keyword used in the inbound message")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("limit")),
                        ("short".to_string(), Value::str("The maximum number of messages that you would like returned in this call.")),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("metadata")),
                        ("short".to_string(), Value::str("An array of objects containing metadata key/value pairs that have been saved on messages.")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("sender")),
                        ("short".to_string(), Value::str("The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("skip")),
                        ("short".to_string(), Value::str("The number of results you would like to ignore before returning messages.")),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("status")),
                        ("short".to_string(), Value::str("The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("to")),
                        ("short".to_string(), Value::str("The date-time to which you would like matching messages")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("unread")),
                        ("short".to_string(), Value::str("In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("message")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/message/flash")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("message")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("flash")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("flash")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("message"),
                                    Value::str("flash"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/message/schedule")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("message")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("schedule")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("schedule")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("message"),
                                    Value::str("schedule"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/message/send")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("message")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("send")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("send")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("message"),
                                    Value::str("send"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/messages")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/messages/failed")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("failed")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("failed")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("failed"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/messages/inbox")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("inbox")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("inbox")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("inbox"),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/messages/{messageid}")),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("messageid".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("{id}"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/messages/schedule")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("schedule")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("schedule")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("schedule"),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/messages/{messageid}")),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("messageid".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("{id}"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("messageid")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/messages/schedule/{messageid}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("schedule")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("messageid")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("messageid"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("schedule"),
                                    Value::str("{messageid}"),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("schedule"),
                        ]),
                    ])),
                ])),
            ])),
            ("one_time_password".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("destination")),
                        ("short".to_string(), Value::str("The phone number of the recipient.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("length")),
                        ("short".to_string(), Value::str("The length of the generated passcode.")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("metadata")),
                        ("short".to_string(), Value::str("A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("passcode")),
                        ("short".to_string(), Value::str("A passcode you supply for use in the message template.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("sender")),
                        ("short".to_string(), Value::str("The sender of the message.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("template")),
                        ("short".to_string(), Value::str("A template to use as the content for the message.")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("validity")),
                        ("short".to_string(), Value::str("The length of time in seconds for which the generated passcode should be valid.")),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("one_time_password")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/otp/send")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("otp")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("send")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("otp"),
                                    Value::str("send"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/otp/verify")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("otp")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("verify")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("otp"),
                                    Value::str("verify"),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("messageid")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/otp/{messageid}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("otp")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("messageid")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("messageid"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("otp"),
                                    Value::str("{messageid}"),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("otp"),
                        ]),
                    ])),
                ])),
            ])),
            ("schedule".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("schedule")),
                ("op".to_string(), Value::empty_map()),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("swagger".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("swagger")),
                ("op".to_string(), Value::empty_map()),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("util".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("util")),
                ("op".to_string(), Value::map_of([
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("errorcode")),
                                            ("orig".to_string(), Value::str("errorcode")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                        ]),
                                    ])),
                                ])),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/utils/errors/{errorcode}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("utils")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("errors")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("errorcode")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("errorcode"),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("utils"),
                                    Value::str("errors"),
                                    Value::str("{errorcode}"),
                                ])),
                            ]),
                            Value::map_of([
                                ("args".to_string(), Value::empty_map()),
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/utils/test")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("utils")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("test")),
                                    ]),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("test")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("utils"),
                                    Value::str("test"),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("error"),
                        ]),
                    ])),
                ])),
            ])),
        ])),
    ])
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// THREAD-LOCAL, not a global: Value is Rc/RefCell-backed and so is neither
// Send nor Sync. One config per thread is the widest scope that is sound here,
// and the clone is an Rc bump, not a deep copy.
thread_local! {
    static SHARED_CONFIG: Value = make_config();
}

/// The per-thread config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() -> Value {
    SHARED_CONFIG.with(|c| c.clone())
}

pub fn make_feature(name: &str) -> FeatureRef {
    match name {
        "debug" => Rc::new(RefCell::new(crate::feature::debug::DebugFeature::new())),
        "idempotency" => Rc::new(RefCell::new(crate::feature::idempotency::IdempotencyFeature::new())),
        "metrics" => Rc::new(RefCell::new(crate::feature::metrics::MetricsFeature::new())),
        "paging" => Rc::new(RefCell::new(crate::feature::paging::PagingFeature::new())),
        "ratelimit" => Rc::new(RefCell::new(crate::feature::ratelimit::RatelimitFeature::new())),
        "retry" => Rc::new(RefCell::new(crate::feature::retry::RetryFeature::new())),
        "test" => Rc::new(RefCell::new(crate::feature::test::TestFeature::new())),
        "timeout" => Rc::new(RefCell::new(crate::feature::timeout::TimeoutFeature::new())),
        _ => Rc::new(RefCell::new(crate::feature::base::BaseFeature::new())),
    }
}
