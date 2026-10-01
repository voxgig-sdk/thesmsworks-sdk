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
      ("version", (Str "0.1.1"));
      ("target", (Str "ocaml")) ]));
    ("feature", (jo [
      ("audit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("actor", (Str "anonymous"));
          ("max", (Num (1000.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sink", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("cache", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("max", (Num (256.)));
          ("methods", (ja [
            (Str "GET") ]));
          ("ttl", (Num (5000.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("clienttrack", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("clientVersion", (Str "0.0.1")) ]));
        ("optspec", (jo [
          ("clientName", (Str "`$STRING`"));
          ("clientVersion", (Str "`$STRING`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("sessionId", (Str "`$STRING`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("cost", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("budget", (Num (0.)));
          ("currency", (Str "USD"));
          ("header", (Str ""));
          ("onBudget", (Str "warn"));
          ("path", (Str ""));
          ("perUnit", (Num (0.)));
          ("rates", (empty_map ()));
          ("unit", (Num (0.))) ]));
        ("optspec", (jo [
          ("actor", (Str "`$STRING`"));
          ("sink", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
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
      ("log", (jo [
        ("options", (jo [
          ("active", (Bool true)) ]));
        ("optspec", (jo [
          ("level", (Str "`$STRING`"));
          ("logger", (Str "`$ANY`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("metrics", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("netsim", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("errorTimes", (Num (0.)));
          ("failEvery", (Num (0.)));
          ("failRate", (Num (0.)));
          ("failStatus", (Num (503.)));
          ("failTimes", (Num (0.)));
          ("latency", (Num (0.)));
          ("offline", (Bool false));
          ("rateLimitTimes", (Num (0.)));
          ("retryAfter", (Num (0.)));
          ("seed", (Num (1.))) ]));
        ("optspec", (jo [
          ("latency", (ja [
            (Str "`$ONE`");
            (Str "`$NUMBER`");
            (Str "`$MAP`") ]));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
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
      ("proxy", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("fromEnv", (Bool false));
          ("noProxy", (empty_list ()));
          ("url", (Str "")) ]));
        ("optspec", (jo [
          ("agent", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
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
      ("rbac", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("deny", (Bool false));
          ("permissions", (empty_list ()));
          ("rules", (empty_map ())) ]));
        ("optspec", (empty_map ()));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
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
      ("secrets", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("cache", (Bool true));
          ("exchange", (jo [
            ("active", (Bool false));
            ("method", (Str "POST"));
            ("path", (Str "auth/token"));
            ("refresh", (Str ""));
            ("request", (Str "refresh_token"));
            ("response", (Str "access_token"));
            ("retries", (Num (1.)));
            ("statuses", (ja [
              (Num (401.)) ])) ]));
          ("name", (Str "apikey"));
          ("providers", (empty_list ())) ]));
        ("optspec", (empty_map ()));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("streaming", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("chunkDelay", (Num (0.)));
          ("chunkSize", (Num (0.))) ]));
        ("optspec", (jo [
          ("ops", (Str "`$LIST`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("telemetry", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("exporter", (Str "`$FUNCTION`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
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
        ("transport", (Str "wrap")) ]));
      ("validate", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("mode", (Str "throw"));
          ("request", (Bool true));
          ("response", (Bool false));
          ("strict", (Bool false)) ]));
        ("optspec", (jo [
          ("mode", (ja [
            (Str "`$ONE`");
            (ja [
              (Str "`$EXACT`");
              (Str "throw") ]);
            (ja [
              (Str "`$EXACT`");
              (Str "report") ]) ]));
          ("onInvalid", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ])) ]));
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
        ("message", (empty_map ()));
        ("one_time_password", (empty_map ()));
        ("util", (empty_map ())) ])) ]));
    ("entity", (jo [
      ("batch", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
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
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/batch/{batchid}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("batchid", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "batchid"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("batch_message", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "ai"));
            ("title", (Str "Ai"));
            ("type", (Str "`$BOOLEAN`"));
            ("short", (Str "Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary.")) ]);
          (jo [
            ("name", (Str "content"));
            ("title", (Str "Content"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Message to send to the recipient")) ]);
          (jo [
            ("name", (Str "deliveryreporturl"));
            ("title", (Str "Deliveryreporturl"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The url to which we should POST delivery reports to for this message.")) ]);
          (jo [
            ("name", (Str "destinations"));
            ("title", (Str "Destinations"));
            ("type", (Str "`$ARRAY`"));
            ("req", (Bool true));
            ("short", (Str "Telephone numbers of each of the recipients")) ]);
          (jo [
            ("name", (Str "schedule"));
            ("title", (Str "Schedule"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Date-time at which to send the batch.")) ]);
          (jo [
            ("name", (Str "sender"));
            ("title", (Str "Sender"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "The sender of the message.")) ]);
          (jo [
            ("name", (Str "tag"));
            ("title", (Str "Tag"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "An identifying label for the message, which you can use to filter and report on messages you've sent later.")) ]);
          (jo [
            ("name", (Str "ttl"));
            ("title", (Str "Ttl"));
            ("type", (Str "`$NUMBER`"));
            ("short", (Str "The number of minutes before the delivery report is deleted.")) ]);
          (jo [
            ("name", (Str "validity"));
            ("title", (Str "Validity"));
            ("type", (Str "`$NUMBER`"));
            ("short", (Str "The optional number of minutes to attempt delivery before the message is marked as EXPIRED.")) ]) ]));
        ("name", (Str "batch_message"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/any"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "any")) ]) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "any") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/schedule"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "schedule") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/batch/send"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "batch")) ]);
                  (jo [
                    ("lit", (Str "send")) ]) ]));
                ("parts", (ja [
                  (Str "batch");
                  (Str "send") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
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
                ("parts", (ja [
                  (Str "batches");
                  (Str "schedule");
                  (Str "{batchid}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "batchid"));
                      ("orig", (Str "batchid"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "batchid") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("credit", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "credit"));
        ("op", (jo [
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/credits/balance"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "credits")) ]);
                  (jo [
                    ("lit", (Str "balance")) ]) ]));
                ("parts", (ja [
                  (Str "credits");
                  (Str "balance") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "balance")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("message", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "credits"));
            ("title", (Str "Credits"));
            ("type", (Str "`$NUMBER`"));
            ("short", (Str "The number of credits used on the message.")) ]);
          (jo [
            ("name", (Str "destination"));
            ("title", (Str "Destination"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The phone number of the recipient.")) ]);
          (jo [
            ("name", (Str "from"));
            ("title", (Str "From"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The date-time from which you would like matching messages")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "keyword"));
            ("title", (Str "Keyword"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The keyword used in the inbound message")) ]);
          (jo [
            ("name", (Str "limit"));
            ("title", (Str "Limit"));
            ("type", (Str "`$NUMBER`"));
            ("short", (Str "The maximum number of messages that you would like returned in this call.")) ]);
          (jo [
            ("name", (Str "metadata"));
            ("title", (Str "Metadata"));
            ("type", (Str "`$OBJECT`"));
            ("short", (Str "An array of objects containing metadata key/value pairs that have been saved on messages.")) ]);
          (jo [
            ("name", (Str "sender"));
            ("title", (Str "Sender"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message).")) ]);
          (jo [
            ("name", (Str "skip"));
            ("title", (Str "Skip"));
            ("type", (Str "`$NUMBER`"));
            ("short", (Str "The number of results you would like to ignore before returning messages.")) ]);
          (jo [
            ("name", (Str "status"));
            ("title", (Str "Status"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING')")) ]);
          (jo [
            ("name", (Str "to"));
            ("title", (Str "To"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The date-time to which you would like matching messages")) ]);
          (jo [
            ("name", (Str "unread"));
            ("title", (Str "Unread"));
            ("type", (Str "`$BOOLEAN`"));
            ("short", (Str "In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false).")) ]) ]));
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
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/flash"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "message")) ]);
                  (jo [
                    ("lit", (Str "flash")) ]) ]));
                ("parts", (ja [
                  (Str "message");
                  (Str "flash") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "flash")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/schedule"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "message")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]) ]));
                ("parts", (ja [
                  (Str "message");
                  (Str "schedule") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "schedule")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/message/send"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "message")) ]);
                  (jo [
                    ("lit", (Str "send")) ]) ]));
                ("parts", (ja [
                  (Str "message");
                  (Str "send") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "send")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]) ]));
                ("parts", (ja [
                  (Str "messages") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/failed"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("lit", (Str "failed")) ]) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "failed") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "failed")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/messages/inbox"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("lit", (Str "inbox")) ]) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "inbox") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "inbox")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/messages/{messageid}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("messageid", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "messageid"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/messages/schedule"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("lit", (Str "schedule")) ]) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "schedule") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "schedule")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/messages/{messageid}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "messages")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "messages");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("messageid", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "messageid"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]);
              (jo [
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
                ("parts", (ja [
                  (Str "messages");
                  (Str "schedule");
                  (Str "{messageid}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "messageid"));
                      ("orig", (Str "messageid"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "messageid") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("one_time_password", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "destination"));
            ("title", (Str "Destination"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The phone number of the recipient.")) ]);
          (jo [
            ("name", (Str "length"));
            ("title", (Str "Length"));
            ("type", (Str "`$OBJECT`"));
            ("short", (Str "The length of the generated passcode.")) ]);
          (jo [
            ("name", (Str "metadata"));
            ("title", (Str "Metadata"));
            ("type", (Str "`$OBJECT`"));
            ("short", (Str "A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application.")) ]);
          (jo [
            ("name", (Str "passcode"));
            ("title", (Str "Passcode"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "A passcode you supply for use in the message template.")) ]);
          (jo [
            ("name", (Str "sender"));
            ("title", (Str "Sender"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The sender of the message.")) ]);
          (jo [
            ("name", (Str "template"));
            ("title", (Str "Template"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "A template to use as the content for the message.")) ]);
          (jo [
            ("name", (Str "validity"));
            ("title", (Str "Validity"));
            ("type", (Str "`$NUMBER`"));
            ("short", (Str "The length of time in seconds for which the generated passcode should be valid.")) ]) ]));
        ("name", (Str "one_time_password"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/otp/send"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "otp")) ]);
                  (jo [
                    ("lit", (Str "send")) ]) ]));
                ("parts", (ja [
                  (Str "otp");
                  (Str "send") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/otp/verify"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "otp")) ]);
                  (jo [
                    ("lit", (Str "verify")) ]) ]));
                ("parts", (ja [
                  (Str "otp");
                  (Str "verify") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/otp/{messageid}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "otp")) ]);
                  (jo [
                    ("var", (Str "messageid")) ]) ]));
                ("parts", (ja [
                  (Str "otp");
                  (Str "{messageid}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "messageid"));
                      ("orig", (Str "messageid"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "messageid") ])) ])) ]) ])) ])) ]));
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
                ("parts", (ja [
                  (Str "utils");
                  (Str "errors");
                  (Str "{errorcode}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "errorcode"));
                      ("orig", (Str "errorcode"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "errorcode") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/utils/test"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "utils")) ]);
                  (jo [
                    ("lit", (Str "test")) ]) ]));
                ("parts", (ja [
                  (Str "utils");
                  (Str "test") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "test")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

(* The plugin definitions the model selected for the secrets feature's
 * provider chain: none - the chain can name the four built-in kinds (env, memory, dotenv, file) and a custom provider, and nothing else.
 * Built, not held: every call is a fresh list, so two chains never share
 * a definition. *)
let feature_plugins (name : string) : Defs.definition list =
  match name with
  | "secrets" -> []
  | _ -> []

let make_feature (name : string) : feature =
  match name with
  | "audit" -> audit_feature ()
  | "cache" -> cache_feature ()
  | "clienttrack" -> clienttrack_feature ()
  | "cost" -> cost_feature ()
  | "debug" -> debug_feature ()
  | "idempotency" -> idempotency_feature ()
  | "log" -> log_feature ()
  | "metrics" -> metrics_feature ()
  | "netsim" -> netsim_feature ()
  | "paging" -> paging_feature ()
  | "proxy" -> proxy_feature ()
  | "ratelimit" -> ratelimit_feature ()
  | "rbac" -> rbac_feature ()
  | "retry" -> retry_feature ()
  | "streaming" -> streaming_feature ()
  | "telemetry" -> telemetry_feature ()
  | "test" -> test_feature ()
  | "timeout" -> timeout_feature ()
  | "validate" -> validate_feature ()
  | "secrets" -> Secrets_feature.make ~plugins:(feature_plugins "secrets") ()
  | _ -> base_feature ()
