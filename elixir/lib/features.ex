# Thesmsworks SDK feature factory

defmodule Thesmsworks.Features do
  def make_feature(name) do
    case name do
      "debug" -> Thesmsworks.Feature.Debug.new()
      "idempotency" -> Thesmsworks.Feature.Idempotency.new()
      "metrics" -> Thesmsworks.Feature.Metrics.new()
      "paging" -> Thesmsworks.Feature.Paging.new()
      "ratelimit" -> Thesmsworks.Feature.Ratelimit.new()
      "retry" -> Thesmsworks.Feature.Retry.new()
      "test" -> Thesmsworks.Feature.Test.new()
      "timeout" -> Thesmsworks.Feature.Timeout.new()
      _ -> Thesmsworks.Feature.new()
    end
  end
end
