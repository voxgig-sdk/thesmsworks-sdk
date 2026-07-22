# Thesmsworks Rust SDK



The Rust SDK for the Thesmsworks API — an entity-oriented client following idiomatic Rust conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.batch(Value::Noval)` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This crate is not yet published to crates.io. Depend on it from the GitHub
release tag (`rust/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) or
from a source checkout by adding it to your `Cargo.toml`:

```toml
[dependencies]
# From a source checkout:
voxgig-thesmsworks-sdk = { path = "../rust" }

# Or from the git release tag:
# voxgig-thesmsworks-sdk = { git = "<repo-url>", tag = "rust/vX.Y.Z" }
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```rust
use thesmsworks_sdk::{getp, jo, ThesmsworksSDK, Value};

let client = ThesmsworksSDK::new(jo(vec![
    ("apikey", Value::str(std::env::var("THESMSWORKS_APIKEY").unwrap_or_default())),
]));
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the bare record and returns `Err` on failure.

```rust
match client.one_time_password(Value::Noval).load(jo(vec![("messageid", Value::str("example_messageid"))]), Value::Noval) {
    Ok(one_time_password) => println!("{:?}", one_time_password),
    Err(err) => eprintln!("load failed: {}", err),
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

```rust
let result = client.direct(jo(vec![
    ("path", Value::str("/api/resource/{id}")),
    ("method", Value::str("GET")),
    ("params", jo(vec![("id", Value::str("example"))])),
])).unwrap();

if getp(&result, "ok") == Value::Bool(true) {
    println!("{:?}", getp(&result, "status"));  // 200
    println!("{:?}", getp(&result, "data"));    // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    println!("{:?} {:?}", getp(&result, "status"), getp(&result, "err"));
}
```

### Prepare a request without sending it

```rust
// prepare() returns the fetch definition on Ok and Err on failure.
let fetchdef = client.prepare(jo(vec![
    ("path", Value::str("/api/resource/{id}")),
    ("method", Value::str("DELETE")),
    ("params", jo(vec![("id", Value::str("example"))])),
])).unwrap();

println!("{:?}", getp(&fetchdef, "url"));
println!("{:?}", getp(&fetchdef, "method"));
println!("{:?}", getp(&fetchdef, "headers"));
```

### Use test mode

Create a mock client for unit testing — no server required:

```rust
let client = test_sdk(Value::Noval, Value::Noval);

// Entity ops return the bare record on Ok and Err on failure.
let batch = client.batch(Value::Noval).load(jo(vec![("id", Value::str("test01"))]), Value::Noval).unwrap();
// batch contains the mock response record
```

### Point at a different server

Override the base URL to reach a local or staging server:

```rust
let client = ThesmsworksSDK::new(jo(vec![
    ("base", Value::str("http://localhost:8080")),
]));
```

### Run live tests

Create a `.env.local` file at the crate root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd rust && cargo test
```


## Reference

### ThesmsworksSDK

```rust
use thesmsworks_sdk::{ThesmsworksSDK, Value};

let client = ThesmsworksSDK::new(options);
```

Creates a new SDK client. `options` is a `Value` map (`Value::Noval` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom fetcher). |

### test_sdk

```rust
use thesmsworks_sdk::{test_sdk, Value};

let client = test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`Value::Noval`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Value` | Deep copy of the current SDK options. |
| `get_utility` | `() -> Rc<Utility>` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs: Value) -> Result<Value, ThesmsworksError>` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs: Value) -> Result<Value, ThesmsworksError>` | Build and send an HTTP request. `Ok` is a result map (branch on `ok`). |
| `batch` | `(entopts: Value) -> Rc<BatchEntity>` | Create a Batch entity instance. |
| `batch_message` | `(entopts: Value) -> Rc<BatchMessageEntity>` | Create a BatchMessage entity instance. |
| `credit` | `(entopts: Value) -> Rc<CreditEntity>` | Create a Credit entity instance. |
| `flash` | `(entopts: Value) -> Rc<FlashEntity>` | Create a Flash entity instance. |
| `message` | `(entopts: Value) -> Rc<MessageEntity>` | Create a Message entity instance. |
| `one_time_password` | `(entopts: Value) -> Rc<OneTimePasswordEntity>` | Create an OneTimePassword entity instance. |
| `schedule` | `(entopts: Value) -> Rc<ScheduleEntity>` | Create a Schedule entity instance. |
| `swagger` | `(entopts: Value) -> Rc<SwaggerEntity>` | Create a Swagger entity instance. |
| `util` | `(entopts: Value) -> Rc<UtilEntity>` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>` | Load a single entity by match criteria. |
| `create` | `(reqdata: Value, ctrl: Value) -> Result<Value, ThesmsworksError>` | Create a new entity. |
| `remove` | `(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>` | Remove an entity. |
| `data` | `(args: Option<&Value>) -> Value` | Get entity data (pass `Some(&map)` to set). |
| `matchv` | `(args: Option<&Value>) -> Value` | Get entity match criteria (pass `Some(&map)` to set). |
| `make` | `() -> Rc<dyn Entity>` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return `Result<Value, ThesmsworksError>` — the
bare result data on `Ok` (a `Value::Map` for single-entity ops, a
`Value::List` for `list`) and the branded error on `Err`.

The `direct()` escape hatch resolves to `Ok` even on a non-2xx response —
it returns a result `Value::Map` you branch on via `getp(&result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

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


### Batch

Create an instance: `let batch = client.batch(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```rust
let batch = client.batch(Value::Noval).load(jo(vec![("id", Value::str("batch_id"))]), Value::Noval).unwrap();
```


### BatchMessage

Create an instance: `let batch_message = client.batch_message(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `String` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `Vec<Value>` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `tag` | `String` |  |
| `ttl` | `f64` |  |
| `validity` | `f64` |  |

#### Example: Create

```rust
let batch_message = client.batch_message(Value::Noval).create(jo(vec![
    ("content", Value::str("example_content")),  // String
    ("destination", Value::empty_list()),  // Vec<Value>
    ("sender", Value::str("example_sender")),  // String
]), Value::Noval).unwrap();
```


### Credit

Create an instance: `let credit = client.credit(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```rust
let credit = client.credit(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```


### Flash

Create an instance: `let flash = client.flash(Value::Noval);`


### Message

Create an instance: `let message = client.message(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `String` |  |
| `credit` | `f64` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `String` |  |
| `from` | `String` |  |
| `keyword` | `String` |  |
| `limit` | `f64` |  |
| `metadata` | `Value` |  |
| `responseemail` | `Vec<Value>` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `skip` | `f64` |  |
| `status` | `String` |  |
| `tag` | `String` |  |
| `to` | `String` |  |
| `ttl` | `f64` |  |
| `unread` | `bool` |  |
| `validity` | `f64` |  |

#### Example: Load

```rust
let message = client.message(Value::Noval).load(jo(vec![("id", Value::str("message_id"))]), Value::Noval).unwrap();
```

#### Example: Create

```rust
let message = client.message(Value::Noval).create(jo(vec![
    ("content", Value::str("example_content")),  // String
    ("destination", Value::str("example_destination")),  // String
    ("sender", Value::str("example_sender")),  // String
]), Value::Noval).unwrap();
```


### OneTimePassword

Create an instance: `let one_time_password = client.one_time_password(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `String` |  |
| `length` | `Value` |  |
| `metadata` | `Value` |  |
| `passcode` | `String` |  |
| `sender` | `String` |  |
| `template` | `String` |  |
| `validity` | `f64` |  |

#### Example: Load

```rust
let one_time_password = client.one_time_password(Value::Noval).load(jo(vec![("messageid", Value::str("messageid"))]), Value::Noval).unwrap();
```

#### Example: Create

```rust
let one_time_password = client.one_time_password(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```


### Schedule

Create an instance: `let schedule = client.schedule(Value::Noval);`


### Swagger

Create an instance: `let swagger = client.swagger(Value::Noval);`


### Util

Create an instance: `let util = client.util(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```rust
let util = client.util(Value::Noval).load(jo(vec![("errorcode", Value::str("errorcode"))]), Value::Noval).unwrap();
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

### Data as `Value`

The Rust SDK uses a single dynamic `Value` type throughout rather than a
typed struct per entity. `Value` is the vendored voxgig struct port (a
JSON-shaped enum: `Str`, `Num`, `Bool`, `List`, `Map`, `Null`,
`Noval`). This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with the `jo` / `ja` helpers and read fields back with
`getp`; use `to_map` to safely coerce a value to a map.

### Crate structure

```
rust/
├── lib.rs                       -- Crate root (module decls + re-exports)
├── core/                        -- Pipeline types, config, client (sdk.rs)
├── entity/                      -- Per-entity clients (one module each)
├── feature/                     -- Built-in features (base, test, log)
└── utility/                     -- Utilities + the vendored voxgig struct port
```

The public API is re-exported from the crate root, so `use thesmsworks_sdk::{...}`
reaches the SDK client, `Value`, and the `jo` / `ja` / `getp` helpers
directly. Import entity or utility modules only when needed.

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
