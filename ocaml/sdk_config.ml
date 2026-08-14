(* Generated API configuration (mirrors go core/config.go).
 *
 * make_config () — the embedded API model as a voxgig struct value.
 * make_feature name — the N-feature-safe factory the client uses. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Sdk_features

let make_config () : value =
  (jo [
    ("main", (jo [
      ("name", (Str "Thesmsworks")) ]));
    ("feature", (jo [
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ])) ])) ]));
    ("options", (jo [
      ("base", (Str "https://api.thesmsworks.co.uk/v1"));
      ("headers", (jo [
        ("content-type", (Str "application/json")) ]));
      ("entity", (jo [
        ("batch", (empty_map ()));
        ("batch_message", (empty_map ()));
        ("credit", (empty_map ()));
        ("flash", (empty_map ()));
        ("message", (empty_map ()));
        ("one_time_password", (empty_map ()));
        ("schedule", (empty_map ()));
        ("swagger", (empty_map ()));
        ("util", (empty_map ())) ]));
      ("auth", (jo [
        ("prefix", (Str "")) ])) ]));
    ("entity", (jo [
      ("batch", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "batch"));
        ("op", (jo [
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("kind", (Str "param"));
                      ("name", (Str "id"));
                      ("orig", (Str "batchid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/batch/{batchid}"));
                ("parts", (ja [
                  (Str "batch");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("batchid", (Str "id")) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("batch_message", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "ai"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "content"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "deliveryreporturl"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "destinations"));
            ("req", (Bool true));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "schedule"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "sender"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "tag"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "ttl"));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "validity"));
            ("type", (Str "`$NUMBER`")) ]) ]));
        ("name", (Str "batch_message"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/any"));
                ("parts", (ja [
                  (Str "batch");
                  (Str "any") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/schedule"));
                ("parts", (ja [
                  (Str "batch");
                  (Str "schedule") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/send"));
                ("parts", (ja [
                  (Str "batch");
                  (Str "send") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("kind", (Str "param"));
                      ("name", (Str "batchid"));
                      ("orig", (Str "batchid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/batches/schedule/{batchid}"));
                ("parts", (ja [
                  (Str "batches");
                  (Str "schedule");
                  (Str "{batchid}") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "batchid") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "schedule") ]) ])) ])) ]));
      ("credit", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "credit"));
        ("op", (jo [
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/credits/balance"));
                ("parts", (ja [
                  (Str "credits");
                  (Str "balance") ]));
                ("select", (jo [
                  ("$action", (Str "balance")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("flash", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "flash"));
        ("op", (empty_map ()));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("message", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "ai"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "content"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "credits"));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "deliveryreporturl"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "destination"));
            ("op", (jo [
              ("create", (jo [
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "from"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "keyword"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "limit"));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "metadata"));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "responseemail"));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "schedule"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "sender"));
            ("op", (jo [
              ("create", (jo [
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "skip"));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "status"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "tag"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "to"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "ttl"));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "unread"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "validity"));
            ("type", (Str "`$NUMBER`")) ]) ]));
        ("name", (Str "message"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/flash"));
                ("parts", (ja [
                  (Str "message");
                  (Str "flash") ]));
                ("select", (jo [
                  ("$action", (Str "flash")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/schedule"));
                ("parts", (ja [
                  (Str "message");
                  (Str "schedule") ]));
                ("select", (jo [
                  ("$action", (Str "schedule")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/send"));
                ("parts", (ja [
                  (Str "message");
                  (Str "send") ]));
                ("select", (jo [
                  ("$action", (Str "send")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages"));
                ("parts", (ja [
                  (Str "messages") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/failed"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "failed") ]));
                ("select", (jo [
                  ("$action", (Str "failed")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/inbox"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "inbox") ]));
                ("select", (jo [
                  ("$action", (Str "inbox")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("kind", (Str "param"));
                      ("name", (Str "id"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/messages/{messageid}"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("messageid", (Str "id")) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/messages/schedule"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "schedule") ]));
                ("select", (jo [
                  ("$action", (Str "schedule")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("kind", (Str "param"));
                      ("name", (Str "id"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/messages/{messageid}"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("messageid", (Str "id")) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("kind", (Str "param"));
                      ("name", (Str "messageid"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/messages/schedule/{messageid}"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "schedule");
                  (Str "{messageid}") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "messageid") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "schedule") ]) ])) ])) ]));
      ("one_time_password", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "destination"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "length"));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "metadata"));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "passcode"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "sender"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "template"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "validity"));
            ("type", (Str "`$NUMBER`")) ]) ]));
        ("name", (Str "one_time_password"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/otp/send"));
                ("parts", (ja [
                  (Str "otp");
                  (Str "send") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/otp/verify"));
                ("parts", (ja [
                  (Str "otp");
                  (Str "verify") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("kind", (Str "param"));
                      ("name", (Str "messageid"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/otp/{messageid}"));
                ("parts", (ja [
                  (Str "otp");
                  (Str "{messageid}") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "messageid") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "otp") ]) ])) ])) ]));
      ("schedule", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "schedule"));
        ("op", (empty_map ()));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("swagger", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "swagger"));
        ("op", (empty_map ()));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("util", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "util"));
        ("op", (jo [
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("kind", (Str "param"));
                      ("name", (Str "errorcode"));
                      ("orig", (Str "errorcode"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/utils/errors/{errorcode}"));
                ("parts", (ja [
                  (Str "utils");
                  (Str "errors");
                  (Str "{errorcode}") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "errorcode") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/utils/test"));
                ("parts", (ja [
                  (Str "utils");
                  (Str "test") ]));
                ("select", (jo [
                  ("$action", (Str "test")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "error") ]) ])) ])) ])) ])) ])

let make_feature (name : string) : feature =
  match name with
  | "test" -> test_feature ()
  | _ -> base_feature ()
