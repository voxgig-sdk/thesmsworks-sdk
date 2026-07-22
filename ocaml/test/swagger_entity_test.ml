(* Generated swagger entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "swagger.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.swagger client Noval in
      check_str "name" ent.e_name "swagger")
