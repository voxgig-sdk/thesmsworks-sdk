// Generated API configuration (mirrors go core/config.go).

use std::cell::RefCell;
use std::rc::Rc;

use crate::core::types::FeatureRef;
use crate::utility::voxgigstruct::Value;

pub fn make_config() -> Value {
    Value::map_of([
        ("main".to_string(), Value::map_of([
            ("name".to_string(), Value::str("Thesmsworks")),
        ])),
        ("feature".to_string(), Value::map_of([
            ("test".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
            ])),
        ])),
        ("options".to_string(), Value::map_of([
            ("base".to_string(), Value::str("https://api.thesmsworks.co.uk/v1")),
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
            ("auth".to_string(), Value::map_of([
                ("prefix".to_string(), Value::str("")),
            ])),
        ])),
        ("entity".to_string(), Value::map_of([
            ("batch".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("batch")),
                ("op".to_string(), Value::map_of([
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("active".to_string(), Value::Bool(true)),
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("batchid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("index$".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/batch/{batchid}")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("batchid".to_string(), Value::str("id")),
                                    ])),
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
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("load")),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("batch_message".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("ai")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("index$".to_string(), Value::Num(0f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("content")),
                        ("req".to_string(), Value::Bool(true)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(1f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("deliveryreporturl")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(2f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("destination")),
                        ("req".to_string(), Value::Bool(true)),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("index$".to_string(), Value::Num(3f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("schedule")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(4f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("sender")),
                        ("req".to_string(), Value::Bool(true)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(5f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("tag")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(6f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("ttl")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(7f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("validity")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(8f64)),
                    ]),
                ])),
                ("name".to_string(), Value::str("batch_message")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/batch/any")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("any"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/batch/schedule")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("schedule"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(1f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/batch/send")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batch"),
                                    Value::str("send"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(2f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("create")),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("active".to_string(), Value::Bool(true)),
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("batchid")),
                                            ("orig".to_string(), Value::str("batchid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("index$".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/batches/schedule/{batchid}")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("batches"),
                                    Value::str("schedule"),
                                    Value::str("{batchid}"),
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
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("remove")),
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
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/credits/balance")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("credits"),
                                    Value::str("balance"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("balance")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("load")),
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
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("ai")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("index$".to_string(), Value::Num(0f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("content")),
                        ("req".to_string(), Value::Bool(true)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(1f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("credit")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(2f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("deliveryreporturl")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(3f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("destination")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(false)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("req".to_string(), Value::Bool(true)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(4f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("from")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(5f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("keyword")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(6f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("limit")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(7f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("metadata")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                        ("index$".to_string(), Value::Num(8f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("responseemail")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("index$".to_string(), Value::Num(9f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("schedule")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(10f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("sender")),
                        ("op".to_string(), Value::map_of([
                            ("create".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(false)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("req".to_string(), Value::Bool(true)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(11f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("skip")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(12f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("status")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(13f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("tag")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(14f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("to")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(15f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("ttl")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(16f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("unread")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("index$".to_string(), Value::Num(17f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("validity")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(18f64)),
                    ]),
                ])),
                ("name".to_string(), Value::str("message")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/message/flash")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("message"),
                                    Value::str("flash"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("flash")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/message/schedule")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("message"),
                                    Value::str("schedule"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("schedule")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(1f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/message/send")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("message"),
                                    Value::str("send"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("send")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(2f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/messages")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(3f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/messages/failed")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("failed"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("failed")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(4f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/messages/inbox")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("inbox"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("inbox")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(5f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("create")),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("active".to_string(), Value::Bool(true)),
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("index$".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/messages/{messageid}")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("messageid".to_string(), Value::str("id")),
                                    ])),
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
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/messages/schedule")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("schedule"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("schedule")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(1f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("load")),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("active".to_string(), Value::Bool(true)),
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("index$".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/messages/{messageid}")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("messageid".to_string(), Value::str("id")),
                                    ])),
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
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("active".to_string(), Value::Bool(true)),
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("messageid")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("index$".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/messages/schedule/{messageid}")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("messages"),
                                    Value::str("schedule"),
                                    Value::str("{messageid}"),
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
                                ("index$".to_string(), Value::Num(1f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("remove")),
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
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("destination")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(0f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("length")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                        ("index$".to_string(), Value::Num(1f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("metadata")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                        ("index$".to_string(), Value::Num(2f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("passcode")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(3f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("sender")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(4f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("template")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("index$".to_string(), Value::Num(5f64)),
                    ]),
                    Value::map_of([
                        ("active".to_string(), Value::Bool(true)),
                        ("name".to_string(), Value::str("validity")),
                        ("req".to_string(), Value::Bool(false)),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("index$".to_string(), Value::Num(6f64)),
                    ]),
                ])),
                ("name".to_string(), Value::str("one_time_password")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/otp/send")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("otp"),
                                    Value::str("send"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/otp/verify")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("otp"),
                                    Value::str("verify"),
                                ])),
                                ("select".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(1f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("create")),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("active".to_string(), Value::Bool(true)),
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("messageid")),
                                            ("orig".to_string(), Value::str("messageid")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("index$".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/otp/{messageid}")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("otp"),
                                    Value::str("{messageid}"),
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
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("load")),
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
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("active".to_string(), Value::Bool(true)),
                                            ("kind".to_string(), Value::str("param")),
                                            ("name".to_string(), Value::str("errorcode")),
                                            ("orig".to_string(), Value::str("errorcode")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("index$".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/utils/errors/{errorcode}")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("utils"),
                                    Value::str("errors"),
                                    Value::str("{errorcode}"),
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
                                ("index$".to_string(), Value::Num(0f64)),
                            ]),
                            Value::map_of([
                                ("active".to_string(), Value::Bool(true)),
                                ("args".to_string(), Value::empty_map()),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/utils/test")),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("utils"),
                                    Value::str("test"),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("test")),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("index$".to_string(), Value::Num(1f64)),
                            ]),
                        ])),
                        ("key$".to_string(), Value::str("load")),
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

pub fn make_feature(name: &str) -> FeatureRef {
    match name {
        "test" => Rc::new(RefCell::new(crate::feature::test::TestFeature::new())),
        _ => Rc::new(RefCell::new(crate::feature::base::BaseFeature::new())),
    }
}
