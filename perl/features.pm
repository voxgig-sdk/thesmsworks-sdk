# Thesmsworks SDK feature factory

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/feature/base_feature.pm"));
require(Cwd::abs_path("$__dir/feature/test_feature.pm"));

package ThesmsworksFeatures;

sub make_feature {
  my ($name) = @_;
  $name = '' unless defined $name;
  return ThesmsworksBaseFeature->new if 'base' eq $name;
  return ThesmsworksTestFeature->new if 'test' eq $name;
  return ThesmsworksBaseFeature->new;
}

1;
