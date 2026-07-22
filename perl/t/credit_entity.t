#!perl
# Credit entity test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use ThesmsworksSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

{
  my $testsdk = ThesmsworksSDK->test(undef, undef);
  my $ent = $testsdk->Credit(undef);
  ok(defined $ent, 'credit: create instance');
}

BASIC_FLOW: {
  my $setup = credit_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op ('load') {
    my ($_should_skip, $_reason) = ThesmsworksTestRunner::is_control_skipped(
      'entityOp', "credit." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('credit: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set THESMSWORKS_TEST_CREDIT_ENTID JSON to run live');
    pass('credit: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # Bootstrap entity data from existing test data.
  $V{credit_ref01_data_raw} = Voxgig::Struct::items(ThesmsworksHelpers::to_map(
    ThesmsworksHelpers::gpath($setup->{data}, 'existing.credit')));
  $V{credit_ref01_data} = undef;
  if (@{ $V{credit_ref01_data_raw} || [] }) {
    $V{credit_ref01_data} = ThesmsworksHelpers::to_map($V{credit_ref01_data_raw}[0][1]);
  }

  # LOAD
  $V{credit_ref01_ent} = $client->Credit(undef);
  $V{credit_ref01_match_dt0} = {};
  $V{credit_ref01_data_dt0_loaded} = $V{credit_ref01_ent}->load($V{credit_ref01_match_dt0}, undef);
  ok(defined $V{credit_ref01_data_dt0_loaded}, 'credit load: data');

}

sub credit_basic_setup {
  my ($extra) = @_;
  ThesmsworksTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/credit/CreditTestData.json");
  my $entity_data = do {
    open my $fh, '<:raw', $entity_data_file or die "Cannot open $entity_data_file: $!";
    local $/;
    Voxgig::Struct::parse_json(<$fh>);
  };

  my $options = {};
  $options->{entity} = $entity_data->{existing};

  my $client = ThesmsworksSDK->test($options, $extra);

  # Generate idmap via transform.
  my $idmap = Voxgig::Struct::transform(
    ['credit01', 'credit02', 'credit03'],
    {
      '`$PACK`' => ['', {
        '`$KEY`' => '`$COPY`',
        '`$VAL`' => ['`$FORMAT`', 'upper', '`$COPY`'],
      }],
    }
  );

  # Detect ENTID env override before env_override consumes it. When live
  # mode is on without a real override, the basic test runs against
  # synthetic IDs from the fixture and 4xx's. Surface this so the test can
  # skip.
  my $entid_env_raw = $ENV{'THESMSWORKS_TEST_CREDIT_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = ThesmsworksTestRunner::env_override({
    'THESMSWORKS_TEST_CREDIT_ENTID' => $idmap,
    'THESMSWORKS_TEST_LIVE' => 'FALSE',
    'THESMSWORKS_TEST_EXPLAIN' => 'FALSE',
    'THESMSWORKS_APIKEY' => 'NONE',
  });

  my $idmap_resolved = ThesmsworksHelpers::to_map($env->{'THESMSWORKS_TEST_CREDIT_ENTID'});
  if (!defined $idmap_resolved) {
    $idmap_resolved = ThesmsworksHelpers::to_map($idmap);
  }

  if ((($env->{'THESMSWORKS_TEST_LIVE'}) || '') eq 'TRUE') {
    my $merged_opts = Voxgig::Struct::merge([
      {
        'apikey' => $env->{'THESMSWORKS_APIKEY'},
      },
      (Voxgig::Struct::ismap($extra) ? $extra : {}),
    ]);
    $client = ThesmsworksSDK->new(ThesmsworksHelpers::to_map($merged_opts));
  }

  my $live = ((($env->{'THESMSWORKS_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;
  return {
    'client' => $client,
    'data' => $entity_data,
    'idmap' => $idmap_resolved,
    'env' => $env,
    'explain' => ((($env->{'THESMSWORKS_TEST_EXPLAIN'}) || '') eq 'TRUE') ? 1 : 0,
    'live' => $live,
    'synthetic_only' => ($live && !$idmap_overridden) ? 1 : 0,
    'now' => ThesmsworksHelpers::now_ms(),
  };
}

done_testing();
