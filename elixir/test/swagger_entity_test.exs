# Swagger entity test (offline, mock transport)

defmodule Thesmsworks.SwaggerEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias Thesmsworks.Helpers, as: H
  alias Thesmsworks.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/swagger/SwaggerTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    Thesmsworks.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.swagger"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = Thesmsworks.test()
    ent = Thesmsworks.swagger(sdk)
    assert ent != nil
  end
end
