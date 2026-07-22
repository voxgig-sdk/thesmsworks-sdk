# Thesmsworks Elixir SDK



The Elixir SDK for the Thesmsworks API — an entity-oriented client
following idiomatic, functional Elixir conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `Thesmsworks.batch(sdk)` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to [Hex](https://hex.pm). Install it from
the GitHub release tag (`elixir/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases))
by adding a git dependency to your `mix.exs`:

```elixir
def deps do
  [
    {:thesmsworks, git: "https://github.com/voxgig-sdk/thesmsworks-sdk.git", tag: "elixir/vX.Y.Z"}
  ]
end
```

Or from a local source checkout:

```elixir
def deps do
  [
    {:thesmsworks, path: "../thesmsworks-sdk/elixir"}
  ]
end
```

Then run `mix deps.get`.


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```elixir
alias Thesmsworks.Helpers, as: H

sdk = Thesmsworks.new(H.deep(%{"apikey" => System.get_env("THESMSWORKS_APIKEY")}))
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load/2` returns the bare record and raises on error.

```elixir
try do
  one_time_password = Thesmsworks.one_time_password(sdk)
  record = Thesmsworks.Entity.OneTimePassword.load(one_time_password, H.deep(%{"messageid" => "example_messageid"}))
  IO.inspect(record)
rescue
  err -> IO.puts("load failed: " <> inspect(err))
end
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

For endpoints not covered by entity operations. `direct/2` never raises —
it returns a result node you branch on with `Voxgig.Struct.getprop/2`:

```elixir
alias Voxgig.Struct, as: S
alias Thesmsworks.Helpers, as: H

result = Thesmsworks.direct(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => %{"id" => "example"}
}))

if S.getprop(result, "ok") do
  IO.inspect(S.getprop(result, "status"))  # 200
  IO.inspect(S.getprop(result, "data"))    # response body
else
  # A non-2xx response carries status + data (the error body); a
  # transport-level failure carries err instead.
  IO.inspect(S.getprop(result, "err"))
end
```

### Prepare a request without sending it

```elixir
alias Thesmsworks.Helpers, as: H

# prepare/2 returns the fetch definition and raises on error.
fetchdef = Thesmsworks.prepare(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "DELETE",
  "params" => %{"id" => "example"}
}))

IO.inspect(Voxgig.Struct.getprop(fetchdef, "url"))
IO.inspect(Voxgig.Struct.getprop(fetchdef, "method"))
```

### Use test mode

Create a mock client for unit testing — no server required:

```elixir
alias Thesmsworks.Helpers, as: H

sdk = Thesmsworks.test()

# Entity ops return the bare record (raise on error).
batch = Thesmsworks.batch(sdk)
record = Thesmsworks.Entity.Batch.load(batch, H.deep(%{"id" => "test01"}))
IO.inspect(record)
```

### Use a custom fetch function

Replace the HTTP transport with your own function. It receives `(url,
fetchdef)` and returns a `{response, error}` tuple:

```elixir
alias Voxgig.Struct, as: S
alias Thesmsworks.Helpers, as: H

mock_fetch = fn _url, _fetchdef ->
  response = H.deep(%{
    "status" => 200,
    "statusText" => "OK",
    "headers" => %{},
    "json" => fn -> %{"id" => "mock01"} end
  })
  {response, nil}
end

sdk = Thesmsworks.new(H.deep(%{
  "base" => "http://localhost:8080",
  "system" => %{"fetch" => mock_fetch}
}))
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd elixir && mix test
```


## Reference

### Thesmsworks

```elixir
sdk = Thesmsworks.new(options)
```

Creates a new SDK client. `options` is a struct value node — build one from a
native map with `Thesmsworks.Helpers.deep/1`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL of the API server. |
| `prefix` | `String.t()` | URL path prefix prepended to all requests. |
| `suffix` | `String.t()` | URL path suffix appended to all requests. |
| `feature` | `map()` | Feature activation flags. |
| `extend` | `list()` | Additional feature instances to load. |
| `system` | `map()` | System overrides (e.g. custom `fetch` function). |

### test

```elixir
sdk = Thesmsworks.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### Thesmsworks functions

| Function | Signature | Description |
| --- | --- | --- |
| `options_map` | `(client) :: map()` | Deep copy of current SDK options. |
| `get_utility` | `(client) :: map()` | The SDK utility node. |
| `prepare` | `(client, fetchargs) :: map()` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(client, fetchargs) :: map()` | Build and send an HTTP request. Returns a result node (branch on `ok`). |
| `batch` | `(client, entopts \\ nil) :: entity` | Create a Batch entity handle. |
| `batch_message` | `(client, entopts \\ nil) :: entity` | Create a BatchMessage entity handle. |
| `credit` | `(client, entopts \\ nil) :: entity` | Create a Credit entity handle. |
| `flash` | `(client, entopts \\ nil) :: entity` | Create a Flash entity handle. |
| `message` | `(client, entopts \\ nil) :: entity` | Create a Message entity handle. |
| `one_time_password` | `(client, entopts \\ nil) :: entity` | Create an OneTimePassword entity handle. |
| `schedule` | `(client, entopts \\ nil) :: entity` | Create a Schedule entity handle. |
| `swagger` | `(client, entopts \\ nil) :: entity` | Create a Swagger entity handle. |
| `util` | `(client, entopts \\ nil) :: entity` | Create an Util entity handle. |

### Entity interface

Every entity's `Thesmsworks.Entity.<Name>` module shares the same interface.

| Function | Signature | Description |
| --- | --- | --- |
| `load` | `(entity, reqmatch, ctrl \\ nil) :: map()` | Load a single entity by match criteria. Raises on error. |
| `create` | `(entity, reqdata, ctrl \\ nil) :: map()` | Create a new entity. Raises on error. |
| `remove` | `(entity, reqmatch \\ nil, ctrl \\ nil) :: map()` | Remove an entity. Raises on error. |
| `data_get` | `(entity) :: map()` | Get entity data. |
| `data_set` | `(entity, data)` | Set entity data. |
| `match_get` | `(entity) :: map()` | Get entity match criteria. |
| `match_set` | `(entity, match)` | Set entity match criteria. |
| `make` | `(entity) :: entity` | Create a new handle with the same options. |
| `get_name` | `(entity) :: String.t()` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a value node — a map for
single-entity ops, a list for `list`) and raise a `Thesmsworks.Error` on
failure. Wrap calls in `try`/`rescue` to handle errors.

The `direct/2` escape hatch never raises — it returns a result node you
branch on via `Voxgig.Struct.getprop(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean()` | `true` if the HTTP status is 2xx. |
| `status` | `integer()` | HTTP status code. |
| `headers` | `map()` | Response headers. |
| `data` | `any()` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error value.

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

Every operation lives on the entity's `Thesmsworks.Entity.<Name>` module and
takes an entity handle built from the client:


### Batch

Create a handle: `batch = Thesmsworks.batch(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Example: Load

```elixir
batch = Thesmsworks.batch(sdk)
record = Thesmsworks.Entity.Batch.load(batch, Thesmsworks.Helpers.deep(%{"id" => "batch_id"}))
```


### BatchMessage

Create a handle: `batch_message = Thesmsworks.batch_message(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `remove(entity, match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean()` |  |
| `content` | `String.t()` |  |
| `deliveryreporturl` | `String.t()` |  |
| `destination` | `list()` |  |
| `schedule` | `String.t()` |  |
| `sender` | `String.t()` |  |
| `tag` | `String.t()` |  |
| `ttl` | `float()` |  |
| `validity` | `float()` |  |

#### Example: Create

```elixir
batch_message = Thesmsworks.batch_message(sdk)
record = Thesmsworks.Entity.BatchMessage.create(batch_message, Thesmsworks.Helpers.deep(%{
  "content" => "example_content",  # String.t()
  "destination" => [],  # list()
  "sender" => "example_sender",  # String.t()
}))
```


### Credit

Create a handle: `credit = Thesmsworks.credit(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Example: Load

```elixir
credit = Thesmsworks.credit(sdk)
record = Thesmsworks.Entity.Credit.load(credit, Thesmsworks.Helpers.deep(%{}))
```


### Flash

Create a handle: `flash = Thesmsworks.flash(sdk)`


### Message

Create a handle: `message = Thesmsworks.message(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `load(entity, match)` | Load a single entity by match criteria. |
| `remove(entity, match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean()` |  |
| `content` | `String.t()` |  |
| `credit` | `float()` |  |
| `deliveryreporturl` | `String.t()` |  |
| `destination` | `String.t()` |  |
| `from` | `String.t()` |  |
| `keyword` | `String.t()` |  |
| `limit` | `float()` |  |
| `metadata` | `map()` |  |
| `responseemail` | `list()` |  |
| `schedule` | `String.t()` |  |
| `sender` | `String.t()` |  |
| `skip` | `float()` |  |
| `status` | `String.t()` |  |
| `tag` | `String.t()` |  |
| `to` | `String.t()` |  |
| `ttl` | `float()` |  |
| `unread` | `boolean()` |  |
| `validity` | `float()` |  |

#### Example: Load

```elixir
message = Thesmsworks.message(sdk)
record = Thesmsworks.Entity.Message.load(message, Thesmsworks.Helpers.deep(%{"id" => "message_id"}))
```

#### Example: Create

```elixir
message = Thesmsworks.message(sdk)
record = Thesmsworks.Entity.Message.create(message, Thesmsworks.Helpers.deep(%{
  "content" => "example_content",  # String.t()
  "destination" => "example_destination",  # String.t()
  "sender" => "example_sender",  # String.t()
}))
```


### OneTimePassword

Create a handle: `one_time_password = Thesmsworks.one_time_password(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `String.t()` |  |
| `length` | `map()` |  |
| `metadata` | `map()` |  |
| `passcode` | `String.t()` |  |
| `sender` | `String.t()` |  |
| `template` | `String.t()` |  |
| `validity` | `float()` |  |

#### Example: Load

```elixir
one_time_password = Thesmsworks.one_time_password(sdk)
record = Thesmsworks.Entity.OneTimePassword.load(one_time_password, Thesmsworks.Helpers.deep(%{"messageid" => "messageid"}))
```

#### Example: Create

```elixir
one_time_password = Thesmsworks.one_time_password(sdk)
record = Thesmsworks.Entity.OneTimePassword.create(one_time_password, Thesmsworks.Helpers.deep(%{
}))
```


### Schedule

Create a handle: `schedule = Thesmsworks.schedule(sdk)`


### Swagger

Create a handle: `swagger = Thesmsworks.swagger(sdk)`


### Util

Create a handle: `util = Thesmsworks.util(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Example: Load

```elixir
util = Thesmsworks.util(sdk)
record = Thesmsworks.Entity.Util.load(util, Thesmsworks.Helpers.deep(%{"errorcode" => "errorcode"}))
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

### Data as struct value nodes

The Elixir SDK models every runtime object — clients, contexts, results and
record data — as reference-stable struct value nodes from the vendored
`Voxgig.Struct` library rather than as compile-time structs. This mirrors
the dynamic nature of the API and lets a feature hook mutate a shared node
that every later pipeline stage observes — the immutable-Elixir way to honour
the shared-mutable hook contract.

Build inputs from native Elixir maps with `Thesmsworks.Helpers.deep/1`,
and read fields off results with `Voxgig.Struct.getprop/2`.

### Module structure

```
elixir/
├── lib/
│   ├── thesmsworks.ex                 -- Main SDK module (entity factories)
│   ├── config.ex                 -- Resolved configuration
│   ├── features.ex               -- Feature factory
│   ├── pipeline.ex               -- Operation pipeline
│   └── thesmsworks/
│       ├── context.ex            -- Operation context
│       ├── entity_base.ex        -- Shared entity behaviour
│       ├── error.ex              -- SDK error type
│       ├── feature.ex            -- Built-in features
│       ├── helpers.ex            -- Value helpers (deep/1, ...)
│       ├── json.ex               -- JSON encode/decode
│       └── utility.ex            -- Utility functions
│   └── entity/                   -- Per-entity modules
├── mix.exs                       -- Package manifest
└── test/                         -- ExUnit suites
```

The main module `Thesmsworks` exposes the SDK constructors and one entity
factory function per entity. Call an operation on the matching
`Thesmsworks.Entity.<Name>` module.

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
