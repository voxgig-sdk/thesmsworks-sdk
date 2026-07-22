(* Generated batch entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "batch.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.batch client Noval in
      check_str "name" ent.e_name "batch")

let () =
  test "batch.seeded_ops" (fun () ->
      let record = jo [("id", Str "batch01")] in
      let seed = jo [("batch",
                      jo [("batch01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.batch client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "batch01")]) Noval in
      check "load is a map" (ismap loaded);
      ())
