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
      ("name", (Str "Thesmsworks"));
      ("slug", (Str "thesmsworks"));
      ("version", (Str "0.0.2"));
      ("target", (Str "ocaml")) ]));
    ("feature", (jo [
      ("debug", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("max", (Num (100.)));
          ("redact", (ja [
            (Str "authorization");
            (Str "cookie");
            (Str "set-cookie");
            (Str "api-key");
            (Str "apikey");
            (Str "x-api-key");
            (Str "idempotency-key") ])) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("onEntry", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("idempotency", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("header", (Str "Idempotency-Key"));
          ("methods", (ja [
            (Str "POST");
            (Str "PUT");
            (Str "PATCH");
            (Str "DELETE") ]));
          ("ops", (ja [
            (Str "create");
            (Str "update");
            (Str "remove") ])) ]));
        ("optspec", (jo [
          ("keygen", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("metrics", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("paging", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("afterVar", (Str "after"));
          ("cursorParam", (Str "cursor"));
          ("firstVar", (Str "first"));
          ("limitParam", (Str "limit"));
          ("pageParam", (Str "page"));
          ("startPage", (Num (1.))) ]));
        ("optspec", (jo [
          ("limit", (Str "`$NUMBER`"));
          ("ops", (Str "`$LIST`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("ratelimit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("burst", (Num (5.)));
          ("rate", (Num (5.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("retry", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("factor", (Num (2.)));
          ("maxDelay", (Num (2000.)));
          ("minDelay", (Num (50.)));
          ("retries", (Num (2.)));
          ("statuses", (ja [
            (Num (408.));
            (Num (425.));
            (Num (429.));
            (Num (500.));
            (Num (502.));
            (Num (503.));
            (Num (504.)) ])) ]));
        ("optspec", (jo [
          ("jitter", (Str "`$BOOLEAN`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("entity", (Str "`$MAP`"));
          ("net", (Str "`$MAP`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "base")) ]));
      ("timeout", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("ms", (Num (30000.))) ]));
        ("optspec", (jo [
          ("clearTimer", (Str "`$FUNCTION`"));
          ("setTimer", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ])) ]));
    ("options", (jo [
      ("base", (Str "https://api.thesmsworks.co.uk/v1"));
      ("auth", (jo [
        ("prefix", (Str "")) ]));
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
        ("util", (empty_map ())) ])) ]));
    ("entity", (jo [
      ("batch", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "id"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
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
                ("rename", (jo [
                  ("param", (jo [
                    ("batchid", (Str "id")) ])) ]));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "{id}") ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("batch_message", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "ai"));
            ("short", (Str "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary."));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "content"));
            ("req", (Bool true));
            ("short", (Str "Message to send to the recipient"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "deliveryreporturl"));
            ("short", (Str "The url to which we should POST delivery reports to for this message."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "destinations"));
            ("req", (Bool true));
            ("short", (Str "Telephone numbers of each of the recipients"));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "schedule"));
            ("short", (Str "Date-time at which to send the batch."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "sender"));
            ("req", (Bool true));
            ("short", (Str "The sender of the message."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "tag"));
            ("short", (Str "An identifying label for the message, which you can use to filter and report on messages you've sent later."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "ttl"));
            ("short", (Str "The number of minutes before the delivery report is deleted."));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "validity"));
            ("short", (Str "The optional number of minutes to attempt delivery before the message is marked as EXPIRED."));
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "any")) ]) ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "any") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/schedule"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]) ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "schedule") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/send"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "send")) ]) ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "send") ])) ]) ])) ]));
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batches")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]);
                  (jo [
                    ("var", (Str "batchid")) ]) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "batchid") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "batches");
                  (Str "schedule");
                  (Str "{batchid}") ])) ]) ])) ])) ]));
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "credits")) ]);
                  (jo [
                    ("lit", (Str "balance")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "balance")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "credits");
                  (Str "balance") ])) ]) ])) ])) ]));
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
            ("name", (Str "credits"));
            ("short", (Str "The number of credits used on the message."));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "destination"));
            ("short", (Str "The phone number of the recipient."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "from"));
            ("short", (Str "The date-time from which you would like matching messages"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "keyword"));
            ("short", (Str "The keyword used in the inbound message"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "limit"));
            ("short", (Str "The maximum number of messages that you would like returned in this call."));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "metadata"));
            ("short", (Str "An array of objects containing metadata key/value pairs that have been saved on messages."));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "sender"));
            ("short", (Str "The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message)."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "skip"));
            ("short", (Str "The number of results you would like to ignore before returning messages."));
            ("type", (Str "`$NUMBER`")) ]);
          (jo [
            ("name", (Str "status"));
            ("short", (Str "The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "to"));
            ("short", (Str "The date-time to which you would like matching messages"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "unread"));
            ("short", (Str "In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false)."));
            ("type", (Str "`$BOOLEAN`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "message")) ]);
                  (jo [
                    ("lit", (Str "flash")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "flash")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "message");
                  (Str "flash") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/schedule"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "message")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "schedule")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "message");
                  (Str "schedule") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/send"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "message")) ]);
                  (jo [
                    ("lit", (Str "send")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "send")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "message");
                  (Str "send") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]) ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "messages") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/failed"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("lit", (Str "failed")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "failed")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "failed") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/inbox"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("lit", (Str "inbox")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "inbox")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "inbox") ])) ]) ])) ]));
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
                ("rename", (jo [
                  ("param", (jo [
                    ("messageid", (Str "id")) ])) ]));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "{id}") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/messages/schedule"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "schedule")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "schedule") ])) ]) ])) ]));
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
                ("rename", (jo [
                  ("param", (jo [
                    ("messageid", (Str "id")) ])) ]));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "{id}") ])) ]);
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]);
                  (jo [
                    ("var", (Str "messageid")) ]) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "messageid") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "schedule");
                  (Str "{messageid}") ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "schedule") ]) ])) ])) ]));
      ("one_time_password", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "destination"));
            ("short", (Str "The phone number of the recipient."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "length"));
            ("short", (Str "The length of the generated passcode."));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "metadata"));
            ("short", (Str "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application."));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "passcode"));
            ("short", (Str "A passcode you supply for use in the message template."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "sender"));
            ("short", (Str "The sender of the message."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "template"));
            ("short", (Str "A template to use as the content for the message."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "validity"));
            ("short", (Str "The length of time in seconds for which the generated passcode should be valid."));
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "otp")) ]);
                  (jo [
                    ("lit", (Str "send")) ]) ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "otp");
                  (Str "send") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/otp/verify"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "otp")) ]);
                  (jo [
                    ("lit", (Str "verify")) ]) ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "otp");
                  (Str "verify") ])) ]) ])) ]));
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "otp")) ]);
                  (jo [
                    ("var", (Str "messageid")) ]) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "messageid") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "otp");
                  (Str "{messageid}") ])) ]) ])) ])) ]));
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
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "utils")) ]);
                  (jo [
                    ("lit", (Str "errors")) ]);
                  (jo [
                    ("var", (Str "errorcode")) ]) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "errorcode") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "utils");
                  (Str "errors");
                  (Str "{errorcode}") ])) ]);
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/utils/test"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "utils")) ]);
                  (jo [
                    ("lit", (Str "test")) ]) ]));
                ("select", (jo [
                  ("$action", (Str "test")) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("parts", (ja [
                  (Str "utils");
                  (Str "test") ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "error") ]) ])) ])) ])) ])) ])

(* The plugin definitions the model selected, per feature: none - no
 * plugin-bearing feature is active in this SDK. *)
let feature_plugins (_name : string) = []

let make_feature (name : string) : feature =
  match name with
  | "debug" -> debug_feature ()
  | "idempotency" -> idempotency_feature ()
  | "metrics" -> metrics_feature ()
  | "paging" -> paging_feature ()
  | "ratelimit" -> ratelimit_feature ()
  | "retry" -> retry_feature ()
  | "test" -> test_feature ()
  | "timeout" -> timeout_feature ()
  | _ -> base_feature ()
