defmodule Thesmsworks.ExistsTest do
  use ExUnit.Case

  test "should create test sdk" do
    testsdk = Thesmsworks.test()
    assert testsdk != nil
  end
end
