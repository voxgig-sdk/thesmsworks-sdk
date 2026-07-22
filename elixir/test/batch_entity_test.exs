# Batch entity test (offline, mock transport)

defmodule Thesmsworks.BatchEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Thesmsworks.Helpers, as: H
  alias Thesmsworks.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/batch/BatchTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Thesmsworks.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.batch"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = Thesmsworks.test()
    ent = Thesmsworks.batch(sdk)
    assert ent != nil
  end

  test "should load an existing record" do
    id = first_id()

    if id != nil do
      sdk = mk_sdk()
      ent = Thesmsworks.batch(sdk)
      rec = Thesmsworks.Entity.Batch.load(ent, S.jm(["id", id]))
      assert S.ismap(rec)
      assert S.getprop(rec, "id") == id
    end
  end
end
