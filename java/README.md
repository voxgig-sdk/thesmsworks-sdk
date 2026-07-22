# Thesmsworks Java SDK



The Java SDK for the Thesmsworks API — an entity-oriented client following idiomatic Java conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.batch(null)` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Maven Central. Install it from the GitHub
release tag (`java/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) or
from a source checkout — build the library with Maven:

```bash
cd java && mvn install
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```java
import voxgig.thesmsworkssdk.core.ThesmsworksSDK;

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("apikey", System.getenv("THESMSWORKS_APIKEY"));
ThesmsworksSDK client = new ThesmsworksSDK(options);
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the bare record (as `Object`) and raises on error.

```java
try {
    Object oneTimePassword = client.oneTimePassword(null).load(Map.of("messageid", "example_messageid"), null);
    System.out.println(oneTimePassword);
}
catch (RuntimeException err) {
    System.out.println("load failed: " + err.getMessage());
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

```java
Map<String, Object> result = client.direct(Map.of(
    "path", "/api/resource/{id}",
    "method", "GET",
    "params", Map.of("id", "example")));

if (Boolean.TRUE.equals(result.get("ok"))) {
    System.out.println(result.get("status"));  // 200
    System.out.println(result.get("data"));    // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // read both — an absent key simply reads as null.
    System.out.println(result.get("status") + " " + result.get("err"));
}
```

### Prepare a request without sending it

```java
// prepare() returns the fetch definition and raises on error.
Map<String, Object> fetchdef = client.prepare(Map.of(
    "path", "/api/resource/{id}",
    "method", "DELETE",
    "params", Map.of("id", "example")));

System.out.println(fetchdef.get("url"));
System.out.println(fetchdef.get("method"));
System.out.println(fetchdef.get("headers"));
```

### Use test mode

Create a mock client for unit testing — no server required:

```java
ThesmsworksSDK client = ThesmsworksSDK.testSDK(null, null);

// Entity ops return the bare record and raise on error.
Object batch = client.batch(null).load(Map.of("id", "test01"), null);
// batch holds the mock response record
System.out.println(batch);
```

### Use a custom fetch function

Replace the HTTP transport with your own `BiFunction`:

```java
java.util.function.BiFunction<String, Map<String, Object>, Object> mockFetch =
    (url, init) -> {
        Map<String, Object> res = new java.util.LinkedHashMap<>();
        res.put("status", 200);
        res.put("statusText", "OK");
        res.put("headers", new java.util.LinkedHashMap<String, Object>());
        res.put("json", (java.util.function.Supplier<Object>) () ->
            Map.of("id", "mock01"));
        return res;
    };

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("base", "http://localhost:8080");
options.put("system", Map.of("fetch", mockFetch));
ThesmsworksSDK client = new ThesmsworksSDK(options);
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd java && mvn test
```


## Reference

### ThesmsworksSDK

```java
ThesmsworksSDK client = new ThesmsworksSDK(options);
```

Creates a new SDK client. `options` is a `Map<String, Object>`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Map` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Map` | System overrides (e.g. custom `fetch` function). |

### testSDK

```java
ThesmsworksSDK client = ThesmsworksSDK.testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Map` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Map` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Map` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `batch` | `(entopts) -> SdkEntity` | Create a Batch entity instance. |
| `batchMessage` | `(entopts) -> SdkEntity` | Create a BatchMessage entity instance. |
| `credit` | `(entopts) -> SdkEntity` | Create a Credit entity instance. |
| `flash` | `(entopts) -> SdkEntity` | Create a Flash entity instance. |
| `message` | `(entopts) -> SdkEntity` | Create a Message entity instance. |
| `oneTimePassword` | `(entopts) -> SdkEntity` | Create an OneTimePassword entity instance. |
| `schedule` | `(entopts) -> SdkEntity` | Create a Schedule entity instance. |
| `swagger` | `(entopts) -> SdkEntity` | Create a Swagger entity instance. |
| `util` | `(entopts) -> SdkEntity` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> Object` | Load a single entity by match criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> Object` | Create a new entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> Object` | Remove an entity. Raises on error. |
| `data` | `(newdata...) -> Object` | Get or set entity data. |
| `match` | `(newmatch...) -> Object` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `getName` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `Map` for single-entity
ops, an aggregate `List` for `list`) as `Object` and raise on error. Wrap
calls in `try`/`catch` to handle failures.

The `direct()` escape hatch never raises — it returns a result
`Map<String, Object>` you branch on via `result.get("ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `Object` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Batch

| Field | Description |
| --- | --- |

Operations: load.

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

Operations: create, remove.

API path: `/batch/any`

#### Credit

| Field | Description |
| --- | --- |

Operations: load.

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

Operations: create, load, remove.

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

Operations: create, load.

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

Operations: load.

API path: `/utils/errors/{errorcode}`



## Entities


### Batch

Create an instance: `SdkEntity batch = client.batch(null);`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |

#### Example: Load

```java
Object batch = client.batch(null).load(Map.of("id", "batch_id"), null);
```


### BatchMessage

Create an instance: `SdkEntity batchMessage = client.batchMessage(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `remove(match, null)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean` |  |
| `content` | `String` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `List<Object>` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `tag` | `String` |  |
| `ttl` | `double` |  |
| `validity` | `double` |  |

#### Example: Create

```java
Object batchMessage = client.batchMessage(null).create(Map.of(
    "content", "example_content",  // String
    "destination", List.of(),  // List<Object>
    "sender", "example_sender"  // String
), null);
```


### Credit

Create an instance: `SdkEntity credit = client.credit(null);`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |

#### Example: Load

```java
Object credit = client.credit(null).load(null, null);
```


### Flash

Create an instance: `SdkEntity flash = client.flash(null);`


### Message

Create an instance: `SdkEntity message = client.message(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `load(match, null)` | Load a single entity by match criteria. |
| `remove(match, null)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean` |  |
| `content` | `String` |  |
| `credit` | `double` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `String` |  |
| `from` | `String` |  |
| `keyword` | `String` |  |
| `limit` | `double` |  |
| `metadata` | `Map<String, Object>` |  |
| `responseemail` | `List<Object>` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `skip` | `double` |  |
| `status` | `String` |  |
| `tag` | `String` |  |
| `to` | `String` |  |
| `ttl` | `double` |  |
| `unread` | `boolean` |  |
| `validity` | `double` |  |

#### Example: Load

```java
Object message = client.message(null).load(Map.of("id", "message_id"), null);
```

#### Example: Create

```java
Object message = client.message(null).create(Map.of(
    "content", "example_content",  // String
    "destination", "example_destination",  // String
    "sender", "example_sender"  // String
), null);
```


### OneTimePassword

Create an instance: `SdkEntity oneTimePassword = client.oneTimePassword(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `load(match, null)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `String` |  |
| `length` | `Map<String, Object>` |  |
| `metadata` | `Map<String, Object>` |  |
| `passcode` | `String` |  |
| `sender` | `String` |  |
| `template` | `String` |  |
| `validity` | `double` |  |

#### Example: Load

```java
Object oneTimePassword = client.oneTimePassword(null).load(Map.of("messageid", "messageid"), null);
```

#### Example: Create

```java
Object oneTimePassword = client.oneTimePassword(null).create(Map.of(
), null);
```


### Schedule

Create an instance: `SdkEntity schedule = client.schedule(null);`


### Swagger

Create an instance: `SdkEntity swagger = client.swagger(null);`


### Util

Create an instance: `SdkEntity util = client.util(null);`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |

#### Example: Load

```java
Object util = client.util(null).load(Map.of("errorcode", "errorcode"), null);
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

### Data as maps

The Java SDK uses a loose object model — `Map<String, Object>` throughout —
rather than a bespoke typed class per endpoint. This mirrors the dynamic
nature of the API and keeps the SDK flexible: no regeneration is needed when
the API schema changes.

Use `Helpers.toMapAny(value)` to safely coerce a value to a
`Map<String, Object>`. A `ThesmsworksTypes.java` module of reference
`record` types is also generated for editor documentation.

### Project structure

```
java/
├── pom.xml                     -- Maven project (compiles core/, utility/, feature/, entity/)
├── core/                       -- Main SDK client, config, entity base, error type
├── entity/                     -- Entity implementations
├── feature/                    -- Built-in features (Base, Test, Log, ...)
├── utility/                    -- Utility functions and the vendored struct library
└── test/                       -- JUnit test suites
```

The main client class (`ThesmsworksSDK`, package `voxgig.thesmsworkssdk.core`)
exposes the entity accessors. Reference entity or utility types directly only
when needed.

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
