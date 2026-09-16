# Thesmsworks SDK feature factory

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/feature/base_feature.pm"));
require(Cwd::abs_path("$__dir/feature/debug_feature.pm"));
require(Cwd::abs_path("$__dir/feature/idempotency_feature.pm"));
require(Cwd::abs_path("$__dir/feature/metrics_feature.pm"));
require(Cwd::abs_path("$__dir/feature/paging_feature.pm"));
require(Cwd::abs_path("$__dir/feature/ratelimit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/retry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/test_feature.pm"));
require(Cwd::abs_path("$__dir/feature/timeout_feature.pm"));

package ThesmsworksFeatures;

sub make_feature {
  my ($name) = @_;
  $name = '' unless defined $name;
  return ThesmsworksBaseFeature->new if 'base' eq $name;
  return ThesmsworksDebugFeature->new if 'debug' eq $name;
  return ThesmsworksIdempotencyFeature->new if 'idempotency' eq $name;
  return ThesmsworksMetricsFeature->new if 'metrics' eq $name;
  return ThesmsworksPagingFeature->new if 'paging' eq $name;
  return ThesmsworksRatelimitFeature->new if 'ratelimit' eq $name;
  return ThesmsworksRetryFeature->new if 'retry' eq $name;
  return ThesmsworksTestFeature->new if 'test' eq $name;
  return ThesmsworksTimeoutFeature->new if 'timeout' eq $name;
  return ThesmsworksBaseFeature->new;
}

1;
