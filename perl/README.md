# Thesmsworks Perl SDK



The Perl SDK for the Thesmsworks API — an entity-oriented client
following idiomatic Perl conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `$client->Batch` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to CPAN. Install it from the GitHub
release tag (`perl/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) or
from a source checkout.

The SDK is pure Perl with zero non-core runtime dependencies, so no build
step is required — just put its `lib` directory on `@INC`:

```perl
use lib 'lib';
use ThesmsworksSDK;
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```perl
use lib 'lib';
use ThesmsworksSDK;

my $client = ThesmsworksSDK->new({
    'apikey' => $ENV{'THESMSWORKS_APIKEY'},
});
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the bare record (a `hashref`) and dies on error.

```perl
my $onetimepassword = eval { $client->OneTimePassword->load({ 'messageid' => 'example_messageid' }) };
if (my $err = $@) {
    print "load failed: $err\n";
}
else {
    print "$onetimepassword->{id}\n";
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const batch = await client.Batch().load({ id: "example_id" })
  console.log(batch)
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```perl
my $result = $client->direct({
    'path' => '/api/resource/{id}',
    'method' => 'GET',
    'params' => { 'id' => 'example' },
});

if ($result->{ok}) {
    print $result->{status}, "\n";  # 200
    print $result->{data}, "\n";    # response body
}
else {
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read whichever is defined.
    print $result->{status}, ' ', ($result->{err} // ''), "\n";
}
```

### Prepare a request without sending it

```perl
# prepare() returns the fetch definition and dies on error.
my $fetchdef = $client->prepare({
    'path' => '/api/resource/{id}',
    'method' => 'DELETE',
    'params' => { 'id' => 'example' },
});

print $fetchdef->{url}, "\n";
print $fetchdef->{method}, "\n";
print $fetchdef->{headers}, "\n";
```

### Use test mode

Create a mock client for unit testing — no server required:

```perl
my $client = ThesmsworksSDK->test(undef, undef);

# Entity ops return the bare record and die on error.
my $batch = $client->Batch->load({ 'id' => 'test01' });
# $batch contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own coderef:

```perl
my $mock_fetch = sub {
    my ($url, $init) = @_;
    return ({
        'status' => 200,
        'statusText' => 'OK',
        'headers' => {},
        'json' => sub { { 'id' => 'mock01' } },
    }, undef);
};

my $client = ThesmsworksSDK->new({
    'base' => 'http://localhost:8080',
    'system' => { 'fetch' => $mock_fetch },
});
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd perl && prove -Ilib t/
```


## Reference

### ThesmsworksSDK

```perl
use lib 'lib';
use ThesmsworksSDK;

my $client = ThesmsworksSDK->new($options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `hashref` | Feature activation flags. |
| `extend` | `arrayref` | Additional feature instances to load. |
| `system` | `hashref` | System overrides (e.g. custom `fetch` coderef). |

### test

```perl
my $client = ThesmsworksSDK->test($testopts, $sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `undef`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> hashref` | Deep copy of current SDK options. |
| `get_utility` | `() -> utility` | Copy of the SDK utility object. |
| `prepare` | `($fetchargs) -> hashref` | Build an HTTP request definition without sending. Dies on error. |
| `direct` | `($fetchargs) -> hashref` | Build and send an HTTP request. Returns a result hashref (branch on `ok`). |
| `Batch` | `($data) -> Batch entity` | Create a Batch entity instance. |
| `BatchMessage` | `($data) -> BatchMessage entity` | Create a BatchMessage entity instance. |
| `Credit` | `($data) -> Credit entity` | Create a Credit entity instance. |
| `Flash` | `($data) -> Flash entity` | Create a Flash entity instance. |
| `Message` | `($data) -> Message entity` | Create a Message entity instance. |
| `OneTimePassword` | `($data) -> OneTimePassword entity` | Create an OneTimePassword entity instance. |
| `Schedule` | `($data) -> Schedule entity` | Create a Schedule entity instance. |
| `Swagger` | `($data) -> Swagger entity` | Create a Swagger entity instance. |
| `Util` | `($data) -> Util entity` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `($reqmatch, $ctrl) -> hashref` | Load a single entity by match criteria. Dies on error. |
| `create` | `($reqdata, $ctrl) -> hashref` | Create a new entity. Dies on error. |
| `remove` | `($reqmatch, $ctrl) -> hashref` | Remove an entity. Dies on error. |
| `data_get` | `() -> hashref` | Get entity data. |
| `data_set` | `($data)` | Set entity data. |
| `match_get` | `() -> hashref` | Get entity match criteria. |
| `match_set` | `($match)` | Set entity match criteria. |
| `make` | `() -> entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `hashref` for single-entity
ops, an `arrayref` for `list`) and die on error. Wrap calls in
`eval { ... }` and inspect `$@` to handle failures.

The `direct()` escape hatch never dies — it returns a result `hashref`
you branch on via `$result->{ok}`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean` | True if the HTTP status is 2xx. |
| `status` | `integer` | HTTP status code. |
| `headers` | `hashref` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is false and `err` contains the error value.

### Entities

#### Batch

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/batch/{batchid}`

#### BatchMessage

| Field | Description |
| --- | --- |
| `ai` |  |
| `content` |  |
| `deliveryreporturl` |  |
| `destination` |  |
| `schedule` |  |
| `sender` |  |
| `tag` |  |
| `ttl` |  |
| `validity` |  |

Operations: Create, Remove.

API path: `/batch/any`

#### Credit

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/credits/balance`

#### Flash

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Message

| Field | Description |
| --- | --- |
| `ai` |  |
| `content` |  |
| `credit` |  |
| `deliveryreporturl` |  |
| `destination` |  |
| `from` |  |
| `keyword` |  |
| `limit` |  |
| `metadata` |  |
| `responseemail` |  |
| `schedule` |  |
| `sender` |  |
| `skip` |  |
| `status` |  |
| `tag` |  |
| `to` |  |
| `ttl` |  |
| `unread` |  |
| `validity` |  |

Operations: Create, Load, Remove.

API path: `/message/flash`

#### OneTimePassword

| Field | Description |
| --- | --- |
| `destination` |  |
| `length` |  |
| `metadata` |  |
| `passcode` |  |
| `sender` |  |
| `template` |  |
| `validity` |  |

Operations: Create, Load.

API path: `/otp/send`

#### Schedule

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Swagger

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Util

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/utils/errors/{errorcode}`



## Entities


### Batch

Create an instance: `my $batch = $client->Batch;`

#### Operations

| Method | Description |
| --- | --- |
| `load($match)` | Load a single entity by match criteria. |

#### Example: Load

```perl
my $batch = $client->Batch->load({ 'id' => 'batch_id' });
```


### BatchMessage

Create an instance: `my $batch_message = $client->BatchMessage;`

#### Operations

| Method | Description |
| --- | --- |
| `create($data)` | Create a new entity with the given data. |
| `remove($match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean` |  |
| `content` | `string` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `arrayref` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `tag` | `string` |  |
| `ttl` | `number` |  |
| `validity` | `number` |  |

#### Example: Create

```perl
my $batch_message = $client->BatchMessage->create({
    'content' => 'example_content',  # string
    'destination' => [],  # arrayref
    'sender' => 'example_sender',  # string
});
```


### Credit

Create an instance: `my $credit = $client->Credit;`

#### Operations

| Method | Description |
| --- | --- |
| `load($match)` | Load a single entity by match criteria. |

#### Example: Load

```perl
my $credit = $client->Credit->load();
```


### Flash

Create an instance: `my $flash = $client->Flash;`


### Message

Create an instance: `my $message = $client->Message;`

#### Operations

| Method | Description |
| --- | --- |
| `create($data)` | Create a new entity with the given data. |
| `load($match)` | Load a single entity by match criteria. |
| `remove($match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean` |  |
| `content` | `string` |  |
| `credit` | `number` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `string` |  |
| `from` | `string` |  |
| `keyword` | `string` |  |
| `limit` | `number` |  |
| `metadata` | `hashref` |  |
| `responseemail` | `arrayref` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `skip` | `number` |  |
| `status` | `string` |  |
| `tag` | `string` |  |
| `to` | `string` |  |
| `ttl` | `number` |  |
| `unread` | `boolean` |  |
| `validity` | `number` |  |

#### Example: Load

```perl
my $message = $client->Message->load({ 'id' => 'message_id' });
```

#### Example: Create

```perl
my $message = $client->Message->create({
    'content' => 'example_content',  # string
    'destination' => 'example_destination',  # string
    'sender' => 'example_sender',  # string
});
```


### OneTimePassword

Create an instance: `my $one_time_password = $client->OneTimePassword;`

#### Operations

| Method | Description |
| --- | --- |
| `create($data)` | Create a new entity with the given data. |
| `load($match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `string` |  |
| `length` | `hashref` |  |
| `metadata` | `hashref` |  |
| `passcode` | `string` |  |
| `sender` | `string` |  |
| `template` | `string` |  |
| `validity` | `number` |  |

#### Example: Load

```perl
my $one_time_password = $client->OneTimePassword->load({ 'messageid' => 'messageid' });
```

#### Example: Create

```perl
my $one_time_password = $client->OneTimePassword->create({
});
```


### Schedule

Create an instance: `my $schedule = $client->Schedule;`


### Swagger

Create an instance: `my $swagger = $client->Swagger;`


### Util

Create an instance: `my $util = $client->Util;`

#### Operations

| Method | Description |
| --- | --- |
| `load($match)` | Load a single entity by match criteria. |

#### Example: Load

```perl
my $util = $client->Util->load({ 'errorcode' => 'errorcode' });
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as hashrefs

The Perl SDK uses plain hashrefs and arrayrefs throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `ThesmsworksHelpers::to_map()` to safely validate that a value
is a hashref.

### Module structure

```
perl/
├── lib/ThesmsworksSDK.pm    -- Main SDK module (package ThesmsworksSDK)
├── config.pm                    -- Configuration
├── features.pm                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (base, test, log)
├── utility/                     -- Utility functions
├── lib/Voxgig/Struct.pm         -- Vendored struct library
└── t/                           -- Test suites
```

Load the main module with `use lib 'lib'; use ThesmsworksSDK;` — it
pulls in the config, features, and core modules for you. Require entity or
utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const batch = client.Batch()
await batch.load({ id: "example_id" })

// batch.data() now returns the batch data from the last `load`
// batch.match() returns { id: "example_id" }
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
