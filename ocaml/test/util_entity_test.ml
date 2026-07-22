(* Generated util entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "util.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.util client Noval in
      check_str "name" ent.e_name "util")

let () =
  test "util.seeded_ops" (fun () ->
      let record = jo [("id", Str "util01")] in
      let seed = jo [("util",
                      jo [("util01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.util client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "util01")]) Noval in
      check "load is a map" (ismap loaded);
      ())
