# Thesmsworks SDK utility: transform_request

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/../lib/Voxgig/Struct.pm"));
require(Cwd::abs_path("$__dir/../core/helpers.pm"));

package ThesmsworksUtilities;

our %REGISTRY;

$REGISTRY{transform_request} = sub {
  my ($ctx) = @_;
  my $spec = $ctx->{spec};
  my $point = $ctx->{point};
  $spec->{step} = 'reqform' if $spec;
  my $transform = ThesmsworksHelpers::to_map(ThesmsworksHelpers::gp($point, 'transform'));
  return $ctx->{reqdata} unless $transform;
  my $reqform = ThesmsworksHelpers::gp($transform, 'req');
  return $ctx->{reqdata} unless ThesmsworksHelpers::rb_truthy($reqform);
  return Voxgig::Struct::transform({ 'reqdata' => $ctx->{reqdata} }, $reqform);
};

1;
