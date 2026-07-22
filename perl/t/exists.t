#!perl
# Thesmsworks SDK exists test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";

use ThesmsworksSDK;

my $testsdk = ThesmsworksSDK->test(undef, undef);
ok(defined $testsdk, 'create test sdk');

done_testing();
