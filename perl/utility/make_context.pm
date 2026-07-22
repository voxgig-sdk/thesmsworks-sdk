# Thesmsworks SDK utility: make_context

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/../core/context.pm"));

package ThesmsworksUtilities;

our %REGISTRY;

$REGISTRY{make_context} = sub {
  my ($ctxmap, $basectx) = @_;
  return ThesmsworksContext->new($ctxmap, $basectx);
};

1;
