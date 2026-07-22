# Thesmsworks Swift SDK



The Swift SDK for the Thesmsworks API — an entity-oriented client following idiomatic Swift conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Batch()` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to a SwiftPM registry. The generated SDK
is a dependency-free SwiftPM package (Foundation only, plus the vendored
Voxgig Struct port). Depend on it from the GitHub release tag
(`swift/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) by adding it to
your `Package.swift`:

```swift
dependencies: [
    // From the git release tag:
    .package(url: "<repo-url>", exact: "0.0.1"),
],
```

Or build from a source checkout with SwiftPM:

```bash
cd swift && swift build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```swift
import ThesmsworksSdk

let options = VMap()
options.entries["apikey"] = .string(
    ProcessInfo.processInfo.environment["THESMSWORKS_APIKEY"] ?? "")
let client = ThesmsworksSDK(options)
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the bare record (a `Value`) and throws on error.

```swift
do {
    let oneTimePassword = try client.OneTimePassword().load(VMap([("messageid", .string("example_messageid"))]), nil)
    print(oneTimePassword)
}
catch {
    print("load failed: \(error)")
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

```swift
let result = client.direct(VMap([
    ("path", .string("/api/resource/{id}")),
    ("method", .string("GET")),
    ("params", .map([("id", .string("example"))])),
]))

if result.entries["ok"] == .bool(true) {
    print(result.entries["status"] ?? .noval)  // 200
    print(result.entries["data"] ?? .noval)     // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // an absent key simply reads as .noval.
    print(result.entries["status"] ?? .noval, result.entries["err"] ?? .noval)
}
```

### Prepare a request without sending it

```swift
// prepare() returns the fetch definition and throws on error.
let fetchdef = try client.prepare(VMap([
    ("path", .string("/api/resource/{id}")),
    ("method", .string("DELETE")),
    ("params", .map([("id", .string("example"))])),
]))

print(fetchdef.entries["url"] ?? .noval)
print(fetchdef.entries["method"] ?? .noval)
print(fetchdef.entries["headers"] ?? .noval)
```

### Use test mode

Create a mock client for unit testing — no server required:

```swift
let client = ThesmsworksSDK.testSDK(nil, nil)

// Entity ops return the bare record and throw on error.
let batch = try client.Batch().load(VMap([("id", .string("test01"))]), nil)
// batch holds the mock response record
print(batch)
```

### Use a custom fetch function

Replace the HTTP transport with your own `SystemFetch` closure:

```swift
let fetch: SystemFetch = { url, _ in
    let m = VMap()
    m.entries["status"] = .int(200)
    m.entries["statusText"] = .string("OK")
    m.entries["headers"] = .map(VMap())
    m.entries["json"] = .nat({ () -> Value in .map(VMap([("id", .string("mock01"))])) } as NativeCall0)
    return .map(m)
}

let system = VMap()
system.entries["fetch"] = .nat(fetch)
let options = VMap()
options.entries["base"] = .string("http://localhost:8080")
options.entries["system"] = .map(system)
let client = ThesmsworksSDK(options)
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd swift && make test
```


## Reference

### ThesmsworksSDK

```swift
let client = ThesmsworksSDK(options)
```

Creates a new SDK client. `options` is a `VMap` of `Value`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `VMap` | Feature activation flags. |
| `extend` | `VList` | Additional Feature instances to load. |
| `system` | `VMap` | System overrides (e.g. custom `fetch` function). |

### testSDK

```swift
let client = ThesmsworksSDK.testSDK(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> VMap` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) throws -> VMap` | Build an HTTP request definition without sending. Throws on error. |
| `direct` | `(fetchargs) -> VMap` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `Batch` | `(entopts) -> ThesmsworksEntityBase` | Create a Batch entity instance. |
| `BatchMessage` | `(entopts) -> ThesmsworksEntityBase` | Create a BatchMessage entity instance. |
| `Credit` | `(entopts) -> ThesmsworksEntityBase` | Create a Credit entity instance. |
| `Flash` | `(entopts) -> ThesmsworksEntityBase` | Create a Flash entity instance. |
| `Message` | `(entopts) -> ThesmsworksEntityBase` | Create a Message entity instance. |
| `OneTimePassword` | `(entopts) -> ThesmsworksEntityBase` | Create an OneTimePassword entity instance. |
| `Schedule` | `(entopts) -> ThesmsworksEntityBase` | Create a Schedule entity instance. |
| `Swagger` | `(entopts) -> ThesmsworksEntityBase` | Create a Swagger entity instance. |
| `Util` | `(entopts) -> ThesmsworksEntityBase` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) throws -> Value` | Load a single entity by match criteria. Throws on error. |
| `create` | `(reqdata, ctrl) throws -> Value` | Create a new entity. Throws on error. |
| `remove` | `(reqmatch, ctrl) throws -> Value` | Remove an entity. Throws on error. |
| `data` | `(newdata?) -> Value` | Get or set entity data. |
| `matchv` | `(newmatch?) -> Value` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `getName` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `Value` map for
single-entity ops, a `Value` list for `list`) and throw on error. Wrap
calls in `do`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `VMap` you
branch on via `result.entries["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Bool` | `true` if the HTTP status is 2xx. |
| `status` | `Int` | HTTP status code. |
| `headers` | `VMap` | Response headers. |
| `data` | `Value` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

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

Create an instance: `let batch = client.Batch()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, nil)` | Load a single entity by match criteria. |

#### Example: Load

```swift
let batch = try client.Batch().load(VMap([("id", .string("batch_id"))]), nil)
```


### BatchMessage

Create an instance: `let batchMessage = client.BatchMessage()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `remove(match, nil)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `Bool` |  |
| `content` | `String` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `[Value]` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `tag` | `String` |  |
| `ttl` | `Double` |  |
| `validity` | `Double` |  |

#### Example: Create

```swift
let batchMessage = try client.BatchMessage().create(VMap([
    ("content", .string("example_content")),  // String
    ("destination", .list([])),  // [Value]
    ("sender", .string("example_sender"))  // String
]), nil)
```


### Credit

Create an instance: `let credit = client.Credit()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, nil)` | Load a single entity by match criteria. |

#### Example: Load

```swift
let credit = try client.Credit().load(nil, nil)
```


### Flash

Create an instance: `let flash = client.Flash()`


### Message

Create an instance: `let message = client.Message()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `load(match, nil)` | Load a single entity by match criteria. |
| `remove(match, nil)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `Bool` |  |
| `content` | `String` |  |
| `credit` | `Double` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `String` |  |
| `from` | `String` |  |
| `keyword` | `String` |  |
| `limit` | `Double` |  |
| `metadata` | `VMap` |  |
| `responseemail` | `[Value]` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `skip` | `Double` |  |
| `status` | `String` |  |
| `tag` | `String` |  |
| `to` | `String` |  |
| `ttl` | `Double` |  |
| `unread` | `Bool` |  |
| `validity` | `Double` |  |

#### Example: Load

```swift
let message = try client.Message().load(VMap([("id", .string("message_id"))]), nil)
```

#### Example: Create

```swift
let message = try client.Message().create(VMap([
    ("content", .string("example_content")),  // String
    ("destination", .string("example_destination")),  // String
    ("sender", .string("example_sender"))  // String
]), nil)
```


### OneTimePassword

Create an instance: `let oneTimePassword = client.OneTimePassword()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `load(match, nil)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `String` |  |
| `length` | `VMap` |  |
| `metadata` | `VMap` |  |
| `passcode` | `String` |  |
| `sender` | `String` |  |
| `template` | `String` |  |
| `validity` | `Double` |  |

#### Example: Load

```swift
let oneTimePassword = try client.OneTimePassword().load(VMap([("messageid", .string("messageid"))]), nil)
```

#### Example: Create

```swift
let oneTimePassword = try client.OneTimePassword().create(VMap([
]), nil)
```


### Schedule

Create an instance: `let schedule = client.Schedule()`


### Swagger

Create an instance: `let swagger = client.Swagger()`


### Util

Create an instance: `let util = client.Util()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, nil)` | Load a single entity by match criteria. |

#### Example: Load

```swift
let util = try client.Util().load(VMap([("errorcode", .string("errorcode"))]), nil)
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

### Data as loose values

The Swift SDK uses a loose object model — the vendored `Value` enum
(with `VMap` / `VList` wrappers) throughout — rather than a bespoke typed
struct per endpoint. This mirrors the dynamic nature of the API and keeps the
SDK flexible: no regeneration is needed when the API schema changes.

Use the `.asMap` / `.asList` / `.asString` accessors to safely coerce a
`Value` to a concrete Swift type (each returns `nil` on a type mismatch).
A `ThesmsworksTypes.swift` file of reference `struct` types is also
generated for editor documentation.

### Project structure

```
swift/
├── Package.swift                     -- SwiftPM manifest (zero runtime deps)
├── Sources/ProjectNameSDK/
│   ├── core/                         -- Main client, config, entity base, error type
│   ├── entity/                       -- Generated entity clients
│   ├── feature/                      -- Built-in features (Base, Test, Log, ...)
│   ├── utility/                      -- Utility functions
│   └── Struct/                       -- Vendored Voxgig Struct port
└── Tests/ProjectNameSDKTests/        -- Test suites (XCTest)
```

The main client class (`ThesmsworksSDK`, under `Sources/ProjectNameSDK/core`)
exposes the entity accessors. Reference entity or utility types directly only
when needed. The SDK is dependency-free: JSON parsing is the vendored
`Struct/JSON.swift`, HTTP transport is Foundation's `URLSession`, and the
struct library is inlined under `Struct/`.

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
