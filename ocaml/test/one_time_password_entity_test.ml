(* Generated one_time_password entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "one_time_password.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.one_time_password client Noval in
      check_str "name" ent.e_name "one_time_password")

let () =
  test "one_time_password.seeded_ops" (fun () ->
      let record = jo [("id", Str "one_time_password01")] in
      let seed = jo [("one_time_password",
                      jo [("one_time_password01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.one_time_password client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "one_time_password01")]) Noval in
      check "load is a map" (ismap loaded);
      ())
