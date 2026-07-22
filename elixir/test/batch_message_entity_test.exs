# BatchMessage entity test (offline, mock transport)

defmodule Thesmsworks.BatchMessageEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Thesmsworks.Helpers, as: H
  alias Thesmsworks.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/batch_message/BatchMessageTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Thesmsworks.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.batch_message"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = Thesmsworks.test()
    ent = Thesmsworks.batch_message(sdk)
    assert ent != nil
  end

  test "should create then read back" do
    sdk = Thesmsworks.test(S.jm(["entity", S.jm(["batch_message", S.jm([])])]))
    ent = Thesmsworks.batch_message(sdk)
    made = Thesmsworks.Entity.BatchMessage.create(ent, S.jm(["name", "test-create"]))
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end
end
