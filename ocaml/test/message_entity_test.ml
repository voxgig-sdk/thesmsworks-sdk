(* Generated message entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "message.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.message client Noval in
      check_str "name" ent.e_name "message")

let () =
  test "message.seeded_ops" (fun () ->
      let record = jo [("id", Str "message01")] in
      let seed = jo [("message",
                      jo [("message01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.message client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "message01")]) Noval in
      check "load is a map" (ismap loaded);
      ())
