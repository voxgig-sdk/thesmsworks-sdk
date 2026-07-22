# Thesmsworks SDK feature factory

defmodule Thesmsworks.Features do
  def make_feature(name) do
    case name do
      "test" -> Thesmsworks.Feature.Test.new()
      _ -> Thesmsworks.Feature.new()
    end
  end
end
