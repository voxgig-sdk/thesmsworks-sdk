(* Generated schedule entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "schedule.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.schedule client Noval in
      check_str "name" ent.e_name "schedule")
