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
                ("active", (Bool true));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "param"));
                      ("name", (Str "id"));
                      ("orig", (Str "batchid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`"));
                      ("index$", (Num (0.))) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "load")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("batch_message", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "ai"));
            ("req", (Bool false));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "content"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "deliveryreporturl"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "destination"));
            ("req", (Bool true));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "schedule"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "sender"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (5.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "tag"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (6.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "ttl"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (7.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "validity"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (8.))) ]) ]));
        ("name", (Str "batch_message"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/any"));
                ("parts", (ja [
                  (Str "batch");
                  (Str "any") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/schedule"));
                ("parts", (ja [
                  (Str "batch");
                  (Str "schedule") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/send"));
                ("parts", (ja [
                  (Str "batch");
                  (Str "send") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (2.))) ]) ]));
            ("key$", (Str "create")) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "param"));
                      ("name", (Str "batchid"));
                      ("orig", (Str "batchid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`"));
                      ("index$", (Num (0.))) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "remove")) ])) ]));
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
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "GET"));
                ("orig", (Str "/credits/balance"));
                ("parts", (ja [
                  (Str "credits");
                  (Str "balance") ]));
                ("select", (jo [
                  ("$action", (Str "balance")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "load")) ])) ]));
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
            ("active", (Bool true));
            ("name", (Str "ai"));
            ("req", (Bool false));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "content"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "credit"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "deliveryreporturl"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "destination"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool false));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "from"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (5.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "keyword"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (6.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "limit"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (7.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "metadata"));
            ("req", (Bool false));
            ("type", (Str "`$OBJECT`"));
            ("index$", (Num (8.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "responseemail"));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (9.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "schedule"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (10.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "sender"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool false));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (11.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "skip"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (12.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "status"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (13.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "tag"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (14.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "to"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (15.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "ttl"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (16.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "unread"));
            ("req", (Bool false));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (17.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "validity"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (18.))) ]) ]));
        ("name", (Str "message"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/message/flash"));
                ("parts", (ja [
                  (Str "message");
                  (Str "flash") ]));
                ("select", (jo [
                  ("$action", (Str "flash")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/message/schedule"));
                ("parts", (ja [
                  (Str "message");
                  (Str "schedule") ]));
                ("select", (jo [
                  ("$action", (Str "schedule")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/message/send"));
                ("parts", (ja [
                  (Str "message");
                  (Str "send") ]));
                ("select", (jo [
                  ("$action", (Str "send")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (2.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/messages"));
                ("parts", (ja [
                  (Str "messages") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (3.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/failed"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "failed") ]));
                ("select", (jo [
                  ("$action", (Str "failed")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (4.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/inbox"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "inbox") ]));
                ("select", (jo [
                  ("$action", (Str "inbox")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (5.))) ]) ]));
            ("key$", (Str "create")) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "param"));
                      ("name", (Str "id"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`"));
                      ("index$", (Num (0.))) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "GET"));
                ("orig", (Str "/messages/schedule"));
                ("parts", (ja [
                  (Str "messages");
                  (Str "schedule") ]));
                ("select", (jo [
                  ("$action", (Str "schedule")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "load")) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "param"));
                      ("name", (Str "id"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`"));
                      ("index$", (Num (0.))) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "param"));
                      ("name", (Str "messageid"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`"));
                      ("index$", (Num (0.))) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "remove")) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "schedule") ]) ])) ])) ]));
      ("one_time_password", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "destination"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "length"));
            ("req", (Bool false));
            ("type", (Str "`$OBJECT`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "metadata"));
            ("req", (Bool false));
            ("type", (Str "`$OBJECT`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "passcode"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "sender"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "template"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (5.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "validity"));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (6.))) ]) ]));
        ("name", (Str "one_time_password"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/otp/send"));
                ("parts", (ja [
                  (Str "otp");
                  (Str "send") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/otp/verify"));
                ("parts", (ja [
                  (Str "otp");
                  (Str "verify") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "create")) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "param"));
                      ("name", (Str "messageid"));
                      ("orig", (Str "messageid"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`"));
                      ("index$", (Num (0.))) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "load")) ])) ]));
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
                ("active", (Bool true));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "param"));
                      ("name", (Str "errorcode"));
                      ("orig", (Str "errorcode"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`"));
                      ("index$", (Num (0.))) ]) ])) ]));
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
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "GET"));
                ("orig", (Str "/utils/test"));
                ("parts", (ja [
                  (Str "utils");
                  (Str "test") ]));
                ("select", (jo [
                  ("$action", (Str "test")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "load")) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "error") ]) ])) ])) ])) ])) ])

let make_feature (name : string) : feature =
  match name with
  | "test" -> test_feature ()
  | _ -> base_feature ()
