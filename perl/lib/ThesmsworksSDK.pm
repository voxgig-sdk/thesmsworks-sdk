# Thesmsworks SDK

use strict;
use warnings;

use File::Basename ();
use Cwd ();
use Scalar::Util ();

package ThesmsworksSDK;

our $VERSION = '0.0.1';

our $DIR;
BEGIN { $DIR = File::Basename::dirname(Cwd::abs_path(__FILE__)) }

require(Cwd::abs_path("$DIR/Voxgig/Struct.pm"));
require(Cwd::abs_path("$DIR/../core/helpers.pm"));
require(Cwd::abs_path("$DIR/../core/utility_type.pm"));
require(Cwd::abs_path("$DIR/../core/spec.pm"));
require(Cwd::abs_path("$DIR/../core/error.pm"));

# Load utility registration
require(Cwd::abs_path("$DIR/../utility/register.pm"));

# Load config and features
require(Cwd::abs_path("$DIR/../config.pm"));
require(Cwd::abs_path("$DIR/../feature/base_feature.pm"));
require(Cwd::abs_path("$DIR/../features.pm"));

sub new {
  my ($class, $options) = @_;
  $options = {} unless defined $options;

  my $self = bless {
    mode => 'live',
    features => [],
    options => undef,
  }, $class;

  my $utility = ThesmsworksUtility->new;
  $self->{_utility} = $utility;

  my $config = ThesmsworksConfig::make_config();

  $self->{_rootctx} = $utility->{make_context}->({
    'client' => $self,
    'utility' => $utility,
    'config' => $config,
    'options' => $options,
    'shared' => {},
  }, undef);

  $self->{options} = $utility->{make_options}->($self->{_rootctx});

  if (ThesmsworksHelpers::is_true(
    ThesmsworksHelpers::gpath($self->{options}, 'feature.test.active'))) {
    $self->{mode} = 'test';
  }

  $self->{_rootctx}{options} = $self->{options};

  # Add features in the resolved order (make_options records an explicit
  # array order, else defaults to test-first). Ordering matters: the `test`
  # feature installs the base mock transport and the transport features
  # (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
  # must be added before them to sit at the base of the wrapper chain.
  my $feature_opts = ThesmsworksHelpers::to_map(
    ThesmsworksHelpers::gp($self->{options}, 'feature')) || {};
  my $featureorder = ThesmsworksHelpers::gpath(
    $self->{options}, '__derived__.featureorder');
  $featureorder = [] unless Voxgig::Struct::islist($featureorder);
  for my $fname (@$featureorder) {
    my $fopts = ThesmsworksHelpers::to_map($feature_opts->{$fname});
    if ($fopts && ThesmsworksHelpers::is_true($fopts->{active})) {
      $utility->{feature_add}->($self->{_rootctx},
        ThesmsworksFeatures::make_feature($fname));
    }
  }

  # Add extension features.
  my $extend = ThesmsworksHelpers::gp($self->{options}, 'extend');
  if (Voxgig::Struct::islist($extend)) {
    for my $f (@$extend) {
      if (Scalar::Util::blessed($f) && $f->can('get_name')) {
        $utility->{feature_add}->($self->{_rootctx}, $f);
      }
    }
  }

  # Initialize features.
  for my $f (@{ $self->{features} }) {
    $utility->{feature_init}->($self->{_rootctx}, $f);
  }

  $utility->{feature_hook}->($self->{_rootctx}, 'PostConstruct');

  return $self;
}

sub options_map {
  my ($self) = @_;
  my $out = Voxgig::Struct::clone($self->{options});
  return Voxgig::Struct::ismap($out) ? $out : {};
}

sub get_utility {
  my ($self) = @_;
  return ThesmsworksUtility->copy($self->{_utility});
}

sub get_root_ctx {
  my ($self) = @_;
  return $self->{_rootctx};
}

sub prepare {
  my ($self, $fetchargs) = @_;
  my $utility = $self->{_utility};
  $fetchargs = {} unless defined $fetchargs;

  my $ctrl = ThesmsworksHelpers::to_map(
    ThesmsworksHelpers::gp($fetchargs, 'ctrl')) || {};

  my $ctx = $utility->{make_context}->({
    'opname' => 'prepare',
    'ctrl' => $ctrl,
  }, $self->{_rootctx});

  my $opts = $self->{options};
  my $path = ThesmsworksHelpers::gp($fetchargs, 'path');
  $path = '' unless defined $path && !ref $path;
  my $method_val = ThesmsworksHelpers::gp($fetchargs, 'method');
  $method_val = 'GET' unless defined $method_val && !ref $method_val;
  my $params = ThesmsworksHelpers::to_map(
    ThesmsworksHelpers::gp($fetchargs, 'params')) || {};
  my $query = ThesmsworksHelpers::to_map(
    ThesmsworksHelpers::gp($fetchargs, 'query')) || {};
  my $headers = $utility->{prepare_headers}->($ctx);

  my $base = ThesmsworksHelpers::gp($opts, 'base');
  $base = '' unless defined $base && !ref $base;
  my $prefix = ThesmsworksHelpers::gp($opts, 'prefix');
  $prefix = '' unless defined $prefix && !ref $prefix;
  my $suffix = ThesmsworksHelpers::gp($opts, 'suffix');
  $suffix = '' unless defined $suffix && !ref $suffix;

  $ctx->{spec} = ThesmsworksSpec->new({
    'base' => $base, 'prefix' => $prefix, 'suffix' => $suffix,
    'path' => $path, 'method' => $method_val,
    'params' => $params, 'query' => $query, 'headers' => $headers,
    'body' => ThesmsworksHelpers::gp($fetchargs, 'body'),
    'step' => 'start',
  });

  # Merge user-provided headers.
  my $uh = ThesmsworksHelpers::gp($fetchargs, 'headers');
  if (Voxgig::Struct::ismap($uh)) {
    $ctx->{spec}{headers}{$_} = $uh->{$_} for keys %$uh;
  }

  my (undef, $err) = $utility->{prepare_auth}->($ctx);
  die $err if $err;

  # make_fetch_def returns a (fetchdef, err) tuple; destructure it and
  # return just the fetchdef hashref (dying on error) so callers -
  # including direct(), which indexes fetchdef->{url} - receive a hashref,
  # mirroring the ts/py/rb prepare().
  my ($fetchdef, $fd_err) = $utility->{make_fetch_def}->($ctx);
  die $fd_err if $fd_err;

  return $fetchdef;
}

sub direct {
  my ($self, $fetchargs) = @_;
  my $utility = $self->{_utility};

  # direct() is the raw-HTTP escape hatch: it always returns a result hash
  # ({ ok => ..., ... }) and never dies. prepare() dies on error, so trap
  # that and surface it in the hash.
  my $fetchdef = eval { $self->prepare($fetchargs) };
  if (my $prep_err = $@) {
    return { 'ok' => 0, 'err' => $prep_err };
  }

  $fetchargs = {} unless defined $fetchargs;
  my $ctrl = ThesmsworksHelpers::to_map(
    ThesmsworksHelpers::gp($fetchargs, 'ctrl')) || {};

  my $ctx = $utility->{make_context}->({
    'opname' => 'direct',
    'ctrl' => $ctrl,
  }, $self->{_rootctx});

  my $url = defined $fetchdef->{url} ? $fetchdef->{url} : '';
  my ($fetched, $fetch_err) = $utility->{fetcher}->($ctx, $url, $fetchdef);

  return { 'ok' => 0, 'err' => $fetch_err } if $fetch_err;

  if (!defined $fetched) {
    return {
      'ok' => 0,
      'err' => $ctx->make_error('direct_no_response', 'response: undefined'),
    };
  }

  if (Voxgig::Struct::ismap($fetched)) {
    my $status = ThesmsworksHelpers::to_int(
      ThesmsworksHelpers::gp($fetched, 'status'));
    my $headers = ThesmsworksHelpers::gp($fetched, 'headers') || {};

    # No-body responses (204, 304) and explicit zero content-length must
    # skip JSON parsing - calling json() on an empty body errors.
    my $content_length = Voxgig::Struct::ismap($headers)
      ? $headers->{'content-length'} : undef;
    my $no_body = (204 == $status || 304 == $status
      || (defined $content_length && '0' eq "$content_length")) ? 1 : 0;

    my $json_data;
    unless ($no_body) {
      my $jf = ThesmsworksHelpers::gp($fetched, 'json');
      if (ref $jf eq 'CODE') {
        # Non-JSON body - leave data undef, keep status/headers.
        $json_data = eval { $jf->() };
      }
    }

    return {
      'ok' => ($status >= 200 && $status < 300) ? 1 : 0,
      'status' => $status,
      'headers' => $headers,
      'data' => $json_data,
    };
  }

  return {
    'ok' => 0,
    'err' => $ctx->make_error('direct_invalid', 'invalid response type'),
  };
}


# Canonical facade: $client->Batch->list / ->load({ 'id' => ... })
sub Batch {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/batch_entity.pm"));
  return BatchEntity->new($self, $data);
}


# Canonical facade: $client->BatchMessage->list / ->load({ 'id' => ... })
sub BatchMessage {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/batch_message_entity.pm"));
  return BatchMessageEntity->new($self, $data);
}


# Canonical facade: $client->Credit->list / ->load({ 'id' => ... })
sub Credit {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/credit_entity.pm"));
  return CreditEntity->new($self, $data);
}


# Canonical facade: $client->Flash->list / ->load({ 'id' => ... })
sub Flash {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/flash_entity.pm"));
  return FlashEntity->new($self, $data);
}


# Canonical facade: $client->Message->list / ->load({ 'id' => ... })
sub Message {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/message_entity.pm"));
  return MessageEntity->new($self, $data);
}


# Canonical facade: $client->OneTimePassword->list / ->load({ 'id' => ... })
sub OneTimePassword {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/one_time_password_entity.pm"));
  return OneTimePasswordEntity->new($self, $data);
}


# Canonical facade: $client->Schedule->list / ->load({ 'id' => ... })
sub Schedule {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/schedule_entity.pm"));
  return ScheduleEntity->new($self, $data);
}


# Canonical facade: $client->Swagger->list / ->load({ 'id' => ... })
sub Swagger {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/swagger_entity.pm"));
  return SwaggerEntity->new($self, $data);
}


# Canonical facade: $client->Util->list / ->load({ 'id' => ... })
sub Util {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/util_entity.pm"));
  return UtilEntity->new($self, $data);
}



sub test {
  my ($class, $testopts, $sdkopts) = @_;
  $sdkopts = {} unless defined $sdkopts;
  $sdkopts = Voxgig::Struct::clone($sdkopts);
  $sdkopts = {} unless Voxgig::Struct::ismap($sdkopts);

  $testopts = {} unless defined $testopts;
  $testopts = Voxgig::Struct::clone($testopts);
  $testopts = {} unless Voxgig::Struct::ismap($testopts);
  $testopts->{active} = Voxgig::Struct::JTRUE();

  Voxgig::Struct::setpath($sdkopts, 'feature.test', $testopts);

  my $sdk = $class->new($sdkopts);
  $sdk->{mode} = 'test';
  return $sdk;
}

1;
