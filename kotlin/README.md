# Thesmsworks Kotlin SDK



The Kotlin SDK for the Thesmsworks API — an entity-oriented client following idiomatic Kotlin conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.batch(null)` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Maven Central. Install it from the GitHub
release tag (`kotlin/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) or
from a source checkout — build the library with Gradle:

```bash
cd kotlin && gradle build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```kotlin
import voxgig.thesmsworkssdk.core.ThesmsworksSDK

val client = ThesmsworksSDK(mutableMapOf<String, Any?>(
    "apikey" to System.getenv("THESMSWORKS_APIKEY"),
))
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the ENTITY — call data() for the record — and raises on error.

```kotlin
try {
    val oneTimePassword = client.oneTimePassword(null).load(mutableMapOf<String, Any?>("messageid" to "example_messageid"), null)
    println(oneTimePassword)
}
catch (err: RuntimeException) {
    println("load failed: " + err.message)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const credit = await client.Credit().load()
  console.log(credit)
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

```kotlin
val result = client.direct(mutableMapOf<String, Any?>(
    "path" to "/api/resource/{id}",
    "method" to "GET",
    "params" to mapOf("id" to "example")))

if (result["ok"] == true) {
    println(result["status"])  // 200
    println(result["data"])    // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // an absent key simply reads as null.
    println("" + result["status"] + " " + result["err"])
}
```

### Prepare a request without sending it

```kotlin
// prepare() returns the fetch definition and raises on error.
val fetchdef = client.prepare(mutableMapOf<String, Any?>(
    "path" to "/api/resource/{id}",
    "method" to "DELETE",
    "params" to mapOf("id" to "example")))

println(fetchdef["url"])
println(fetchdef["method"])
println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```kotlin
val client = ThesmsworksSDK.testSDK(null, null)

// Entity ops return the ENTITY and raises on error;
// call data() for the record.
val credit = client.credit(null).load(null, null)
// credit holds the mock response record
println(credit)
```

### Use a custom fetch function

Replace the HTTP transport with your own `BiFunction`:

```kotlin
val mockFetch = java.util.function.BiFunction<String, MutableMap<String, Any?>, Any?> { url, init ->
    mutableMapOf<String, Any?>(
        "status" to 200,
        "statusText" to "OK",
        "headers" to mutableMapOf<String, Any?>(),
        "json" to java.util.function.Supplier<Any?> { mapOf("id" to "mock01") },
    )
}

val client = ThesmsworksSDK(mutableMapOf<String, Any?>(
    "base" to "http://localhost:8080",
    "system" to mapOf("fetch" to mockFetch),
))
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd kotlin && gradle test
```


## Reference

### ThesmsworksSDK

```kotlin
val client = ThesmsworksSDK(options)
```

Creates a new SDK client. `options` is a `MutableMap<String, Any?>`.

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

```kotlin
val client = ThesmsworksSDK.testSDK(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> MutableMap` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> MutableMap` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> MutableMap` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
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
| `load` | `(reqmatch, ctrl) -> Any?` | Load a single entity by match criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> Any?` | Create a new entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> Any?` | Remove an entity. Raises on error. |
| `data` | `(vararg newdata) -> Any?` | Get or set entity data. |
| `match` | `(vararg newmatch) -> Any?` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `name` | `val: String` | The entity name. |

### Result shape

Entity operations return the ENTITY (call data() for the record) (a `Map` for single-entity
ops, an aggregate `List` for `list`) as `Any?` and raise on error. Wrap
calls in `try`/`catch` to handle failures.

The `direct()` escape hatch never raises — it returns a result
`MutableMap<String, Any?>` you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `Int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `Any?` | Parsed JSON response body. |

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
| `ai` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | Message to send to the recipient |
| `deliveryreporturl` | The url to which we should POST delivery reports to for this message. |
| `destinations` | Telephone numbers of each of the recipients |
| `schedule` | Date-time at which to send the batch. |
| `sender` | The sender of the message. |
| `tag` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | The number of minutes before the delivery report is deleted. |
| `validity` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

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
| `ai` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | Message to send to the recipient. |
| `credits` | The number of credits used on the message. |
| `deliveryreporturl` | The url to which we should POST delivery reports to for this message. |
| `destination` | Telephone number of the recipient |
| `from` | The date-time from which you would like matching messages |
| `keyword` | The keyword used in the inbound message |
| `limit` | The maximum number of messages that you would like returned in this call. |
| `metadata` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | Date at which to send the message. |
| `sender` | The sender of the message. |
| `skip` | The number of results you would like to ignore before returning messages. |
| `status` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | The date-time to which you would like matching messages |
| `ttl` | The optional number of minutes before the delivery report is deleted. |
| `unread` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

Operations: create, load, remove.

API path: `/message/flash`

#### OneTimePassword

| Field | Description |
| --- | --- |
| `destination` | The phone number of the recipient. |
| `length` | The length of the generated passcode. |
| `metadata` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | A passcode you supply for use in the message template. |
| `sender` | The sender of the message. |
| `template` | A template to use as the content for the message. |
| `validity` | The length of time in seconds for which the generated passcode should be valid. |

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

Create an instance: `val batch = client.batch(null)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |

#### Example: Load

```kotlin
val batch = client.batch(null).load(mutableMapOf<String, Any?>("id" to "batch_id"), null)
```


### BatchMessage

Create an instance: `val batchMessage = client.batchMessage(null)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `remove(match, null)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `Boolean?` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String?` | Message to send to the recipient |
| `deliveryreporturl` | `String?` | The url to which we should POST delivery reports to for this message. |
| `destinations` | `List<Any?>?` | Telephone numbers of each of the recipients |
| `schedule` | `String?` | Date-time at which to send the batch. |
| `sender` | `String?` | The sender of the message. |
| `tag` | `String?` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `Double?` | The number of minutes before the delivery report is deleted. |
| `validity` | `Double?` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Create

```kotlin
val batchMessage = client.batchMessage(null).create(mutableMapOf<String, Any?>(
    "content" to "example_content",  // String?
    "destinations" to listOf<Any?>(),  // List<Any?>?
    "sender" to "example_sender"  // String?
), null)
```


### Credit

Create an instance: `val credit = client.credit(null)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |

#### Example: Load

```kotlin
val credit = client.credit(null).load(null, null)
```


### Flash

Create an instance: `val flash = client.flash(null)`


### Message

Create an instance: `val message = client.message(null)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `load(match, null)` | Load a single entity by match criteria. |
| `remove(match, null)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `Boolean?` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String?` | Message to send to the recipient. |
| `credits` | `Double?` | The number of credits used on the message. |
| `deliveryreporturl` | `String?` | The url to which we should POST delivery reports to for this message. |
| `destination` | `String?` | Telephone number of the recipient |
| `from` | `String?` | The date-time from which you would like matching messages |
| `keyword` | `String?` | The keyword used in the inbound message |
| `limit` | `Double?` | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Map<String, Any?>?` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `List<Any?>?` | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `String?` | Date at which to send the message. |
| `sender` | `String?` | The sender of the message. |
| `skip` | `Double?` | The number of results you would like to ignore before returning messages. |
| `status` | `String?` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `String?` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `String?` | The date-time to which you would like matching messages |
| `ttl` | `Double?` | The optional number of minutes before the delivery report is deleted. |
| `unread` | `Boolean?` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `Double?` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Load

```kotlin
val message = client.message(null).load(mutableMapOf<String, Any?>("id" to "message_id"), null)
```

#### Example: Create

```kotlin
val message = client.message(null).create(mutableMapOf<String, Any?>(
    "content" to "example_content",  // String?
    "destination" to "example_destination",  // String?
    "sender" to "example_sender"  // String?
), null)
```


### OneTimePassword

Create an instance: `val oneTimePassword = client.oneTimePassword(null)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `load(match, null)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `String?` | The phone number of the recipient. |
| `length` | `Map<String, Any?>?` | The length of the generated passcode. |
| `metadata` | `Map<String, Any?>?` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String?` | A passcode you supply for use in the message template. |
| `sender` | `String?` | The sender of the message. |
| `template` | `String?` | A template to use as the content for the message. |
| `validity` | `Double?` | The length of time in seconds for which the generated passcode should be valid. |

#### Example: Load

```kotlin
val oneTimePassword = client.oneTimePassword(null).load(mutableMapOf<String, Any?>("messageid" to "messageid"), null)
```

#### Example: Create

```kotlin
val oneTimePassword = client.oneTimePassword(null).create(mutableMapOf<String, Any?>(
), null)
```


### Schedule

Create an instance: `val schedule = client.schedule(null)`


### Swagger

Create an instance: `val swagger = client.swagger(null)`


### Util

Create an instance: `val util = client.util(null)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |

#### Example: Load

```kotlin
val util = client.util(null).load(mutableMapOf<String, Any?>("errorcode" to "errorcode"), null)
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

The Kotlin SDK uses a loose object model — `MutableMap<String, Any?>`
throughout — rather than a bespoke typed class per endpoint. This mirrors the
dynamic nature of the API and keeps the SDK flexible: no regeneration is
needed when the API schema changes.

Use `Helpers.toMapAny(value)` to safely coerce a value to a
`MutableMap<String, Any?>`. A `ThesmsworksTypes.kt` module of
reference `data class` types is also generated for editor documentation.

### Project structure

```
kotlin/
├── build.gradle.kts            -- Gradle build (compiles core/, utility/, feature/, entity/)
├── settings.gradle.kts         -- Gradle project settings
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
const credit = client.Credit()
await credit.load()

// credit.data() now returns the credit data from the last `load`
// credit.match() returns the last match criteria
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
