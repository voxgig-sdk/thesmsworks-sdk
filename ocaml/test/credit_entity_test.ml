(* Generated credit entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "credit.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.credit client Noval in
      check_str "name" ent.e_name "credit")

let () =
  test "credit.seeded_ops" (fun () ->
      let record = jo [("id", Str "credit01")] in
      let seed = jo [("credit",
                      jo [("credit01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.credit client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "credit01")]) Noval in
      check "load is a map" (ismap loaded);
      ())
