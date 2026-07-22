(* Generated batch_message entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "batch_message.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.batch_message client Noval in
      check_str "name" ent.e_name "batch_message")
