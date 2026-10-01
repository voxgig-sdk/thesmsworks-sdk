# Thesmsworks SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/audit_feature'
require_relative 'feature/cache_feature'
require_relative 'feature/clienttrack_feature'
require_relative 'feature/cost_feature'
require_relative 'feature/debug_feature'
require_relative 'feature/idempotency_feature'
require_relative 'feature/log_feature'
require_relative 'feature/metrics_feature'
require_relative 'feature/netsim_feature'
require_relative 'feature/paging_feature'
require_relative 'feature/proxy_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/rbac_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/secrets_feature'
require_relative 'feature/streaming_feature'
require_relative 'feature/telemetry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'
require_relative 'feature/validate_feature'


module ThesmsworksFeatures
  def self.make_feature(name)
    case name
    when "base"
      ThesmsworksBaseFeature.new
    when "audit"
      ThesmsworksAuditFeature.new
    when "cache"
      ThesmsworksCacheFeature.new
    when "clienttrack"
      ThesmsworksClienttrackFeature.new
    when "cost"
      ThesmsworksCostFeature.new
    when "debug"
      ThesmsworksDebugFeature.new
    when "idempotency"
      ThesmsworksIdempotencyFeature.new
    when "log"
      ThesmsworksLogFeature.new
    when "metrics"
      ThesmsworksMetricsFeature.new
    when "netsim"
      ThesmsworksNetsimFeature.new
    when "paging"
      ThesmsworksPagingFeature.new
    when "proxy"
      ThesmsworksProxyFeature.new
    when "ratelimit"
      ThesmsworksRatelimitFeature.new
    when "rbac"
      ThesmsworksRbacFeature.new
    when "retry"
      ThesmsworksRetryFeature.new
    when "secrets"
      ThesmsworksSecretsFeature.new
    when "streaming"
      ThesmsworksStreamingFeature.new
    when "telemetry"
      ThesmsworksTelemetryFeature.new
    when "test"
      ThesmsworksTestFeature.new
    when "timeout"
      ThesmsworksTimeoutFeature.new
    when "validate"
      ThesmsworksValidateFeature.new
    else
      ThesmsworksBaseFeature.new
    end
  end
end
