# Thesmsworks SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/debug_feature'
require_relative 'feature/idempotency_feature'
require_relative 'feature/metrics_feature'
require_relative 'feature/paging_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module ThesmsworksFeatures
  def self.make_feature(name)
    case name
    when "base"
      ThesmsworksBaseFeature.new
    when "debug"
      ThesmsworksDebugFeature.new
    when "idempotency"
      ThesmsworksIdempotencyFeature.new
    when "metrics"
      ThesmsworksMetricsFeature.new
    when "paging"
      ThesmsworksPagingFeature.new
    when "ratelimit"
      ThesmsworksRatelimitFeature.new
    when "retry"
      ThesmsworksRetryFeature.new
    when "test"
      ThesmsworksTestFeature.new
    when "timeout"
      ThesmsworksTimeoutFeature.new
    else
      ThesmsworksBaseFeature.new
    end
  end
end
