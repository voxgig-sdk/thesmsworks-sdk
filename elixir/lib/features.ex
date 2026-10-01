# Thesmsworks SDK feature factory

defmodule Thesmsworks.Features do
  def make_feature(name) do
    case name do
      "audit" -> Thesmsworks.Feature.Audit.new()
      "cache" -> Thesmsworks.Feature.Cache.new()
      "clienttrack" -> Thesmsworks.Feature.Clienttrack.new()
      "cost" -> Thesmsworks.Feature.Cost.new()
      "debug" -> Thesmsworks.Feature.Debug.new()
      "idempotency" -> Thesmsworks.Feature.Idempotency.new()
      "log" -> Thesmsworks.Feature.Log.new()
      "metrics" -> Thesmsworks.Feature.Metrics.new()
      "netsim" -> Thesmsworks.Feature.Netsim.new()
      "paging" -> Thesmsworks.Feature.Paging.new()
      "proxy" -> Thesmsworks.Feature.Proxy.new()
      "ratelimit" -> Thesmsworks.Feature.Ratelimit.new()
      "rbac" -> Thesmsworks.Feature.Rbac.new()
      "retry" -> Thesmsworks.Feature.Retry.new()
      "secrets" -> Thesmsworks.Feature.Secrets.new()
      "streaming" -> Thesmsworks.Feature.Streaming.new()
      "telemetry" -> Thesmsworks.Feature.Telemetry.new()
      "test" -> Thesmsworks.Feature.Test.new()
      "timeout" -> Thesmsworks.Feature.Timeout.new()
      "validate" -> Thesmsworks.Feature.Validate.new()
      _ -> Thesmsworks.Feature.new()
    end
  end
end
