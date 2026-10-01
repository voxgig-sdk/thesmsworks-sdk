# Thesmsworks SDK feature factory

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/feature/base_feature.pm"));
require(Cwd::abs_path("$__dir/feature/audit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/cache_feature.pm"));
require(Cwd::abs_path("$__dir/feature/clienttrack_feature.pm"));
require(Cwd::abs_path("$__dir/feature/cost_feature.pm"));
require(Cwd::abs_path("$__dir/feature/debug_feature.pm"));
require(Cwd::abs_path("$__dir/feature/idempotency_feature.pm"));
require(Cwd::abs_path("$__dir/feature/log_feature.pm"));
require(Cwd::abs_path("$__dir/feature/metrics_feature.pm"));
require(Cwd::abs_path("$__dir/feature/netsim_feature.pm"));
require(Cwd::abs_path("$__dir/feature/paging_feature.pm"));
require(Cwd::abs_path("$__dir/feature/proxy_feature.pm"));
require(Cwd::abs_path("$__dir/feature/ratelimit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/rbac_feature.pm"));
require(Cwd::abs_path("$__dir/feature/retry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/secrets_feature.pm"));
require(Cwd::abs_path("$__dir/feature/streaming_feature.pm"));
require(Cwd::abs_path("$__dir/feature/telemetry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/test_feature.pm"));
require(Cwd::abs_path("$__dir/feature/timeout_feature.pm"));
require(Cwd::abs_path("$__dir/feature/validate_feature.pm"));

package ThesmsworksFeatures;

sub make_feature {
  my ($name) = @_;
  $name = '' unless defined $name;
  return ThesmsworksBaseFeature->new if 'base' eq $name;
  return ThesmsworksAuditFeature->new if 'audit' eq $name;
  return ThesmsworksCacheFeature->new if 'cache' eq $name;
  return ThesmsworksClienttrackFeature->new if 'clienttrack' eq $name;
  return ThesmsworksCostFeature->new if 'cost' eq $name;
  return ThesmsworksDebugFeature->new if 'debug' eq $name;
  return ThesmsworksIdempotencyFeature->new if 'idempotency' eq $name;
  return ThesmsworksLogFeature->new if 'log' eq $name;
  return ThesmsworksMetricsFeature->new if 'metrics' eq $name;
  return ThesmsworksNetsimFeature->new if 'netsim' eq $name;
  return ThesmsworksPagingFeature->new if 'paging' eq $name;
  return ThesmsworksProxyFeature->new if 'proxy' eq $name;
  return ThesmsworksRatelimitFeature->new if 'ratelimit' eq $name;
  return ThesmsworksRbacFeature->new if 'rbac' eq $name;
  return ThesmsworksRetryFeature->new if 'retry' eq $name;
  return ThesmsworksSecretsFeature->new if 'secrets' eq $name;
  return ThesmsworksStreamingFeature->new if 'streaming' eq $name;
  return ThesmsworksTelemetryFeature->new if 'telemetry' eq $name;
  return ThesmsworksTestFeature->new if 'test' eq $name;
  return ThesmsworksTimeoutFeature->new if 'timeout' eq $name;
  return ThesmsworksValidateFeature->new if 'validate' eq $name;
  return ThesmsworksBaseFeature->new;
}

1;
