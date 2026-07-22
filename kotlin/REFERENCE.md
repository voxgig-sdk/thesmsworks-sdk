# Thesmsworks Kotlin SDK Reference

Complete API reference for the Thesmsworks Kotlin SDK.


## ThesmsworksSDK

### Constructor

```kotlin
val client = ThesmsworksSDK(options)
```

Create a new SDK client instance. `options` is a `MutableMap<String, Any?>`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Map` | Custom headers for all requests. |
| `options["feature"]` | `Map` | Feature configuration. |
| `options["system"]` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `null`.

```kotlin
val client = ThesmsworksSDK.testSDK(null, null)
```


### Instance Methods

#### `batch(entopts)`

Create a new `Batch` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `batchMessage(entopts)`

Create a new `BatchMessage` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `credit(entopts)`

Create a new `Credit` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `flash(entopts)`

Create a new `Flash` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `message(entopts)`

Create a new `Message` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `oneTimePassword(entopts)`

Create a new `OneTimePassword` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `schedule(entopts)`

Create a new `Schedule` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `swagger(entopts)`

Create a new `Swagger` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `util(entopts)`

Create a new `Util` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optionsMap() -> MutableMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> MutableMap`

Make a direct HTTP request to any API endpoint. Returns a result
`MutableMap<String, Any?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Any?` | Request body (maps are JSON-serialized). |

**Returns:** `MutableMap<String, Any?>`

#### `prepare(fetchargs) -> MutableMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Batch

```kotlin
val batch = client.batch(null)
```

### Operations

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```kotlin
val result = client.batch(null).load(mutableMapOf<String, Any?>("id" to "batch_id"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Batch` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## BatchMessage

```kotlin
val batchMessage = client.batchMessage(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `Boolean` | No |  |
| `content` | `String` | Yes |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `List<Any?>` | Yes |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `tag` | `String` | No |  |
| `ttl` | `Double` | No |  |
| `validity` | `Double` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.batchMessage(null).create(mutableMapOf<String, Any?>(
    "content" to "example_content",  // String
    "destination" to listOf<Any?>(),  // List<Any?>
    "sender" to "example_sender"  // String
), null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Raises on error.

```kotlin
val result = client.batchMessage(null).remove(mutableMapOf<String, Any?>("batchid" to "batchid"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchMessage` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Credit

```kotlin
val credit = client.credit(null)
```

### Operations

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```kotlin
val result = client.credit(null).load(null, null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Credit` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Flash

```kotlin
val flash = client.flash(null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Flash` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Message

```kotlin
val message = client.message(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `Boolean` | No |  |
| `content` | `String` | Yes |  |
| `credit` | `Double` | No |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `String` | Yes |  |
| `from` | `String` | No |  |
| `keyword` | `String` | No |  |
| `limit` | `Double` | No |  |
| `metadata` | `Map<String, Any?>` | No |  |
| `responseemail` | `List<Any?>` | No |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `skip` | `Double` | No |  |
| `status` | `String` | No |  |
| `tag` | `String` | No |  |
| `to` | `String` | No |  |
| `ttl` | `Double` | No |  |
| `unread` | `Boolean` | No |  |
| `validity` | `Double` | No |  |

### Field Usage by Operation

| Field | load | create | remove |
| --- | --- | --- | --- |
| `ai` | - | - | - |
| `content` | - | - | - |
| `credit` | - | - | - |
| `deliveryreporturl` | - | - | - |
| `destination` | - | Yes | - |
| `from` | - | - | - |
| `keyword` | - | - | - |
| `limit` | - | - | - |
| `metadata` | - | - | - |
| `responseemail` | - | - | - |
| `schedule` | - | - | - |
| `sender` | - | Yes | - |
| `skip` | - | - | - |
| `status` | - | - | - |
| `tag` | - | - | - |
| `to` | - | - | - |
| `ttl` | - | - | - |
| `unread` | - | - | - |
| `validity` | - | - | - |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.message(null).create(mutableMapOf<String, Any?>(
    "content" to "example_content",  // String
    "destination" to "example_destination",  // String
    "sender" to "example_sender"  // String
), null)
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```kotlin
val result = client.message(null).load(mutableMapOf<String, Any?>("id" to "message_id"), null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Raises on error.

```kotlin
val result = client.message(null).remove(mutableMapOf<String, Any?>("id" to "message_id"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Message` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## OneTimePassword

```kotlin
val oneTimePassword = client.oneTimePassword(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No |  |
| `length` | `Map<String, Any?>` | No |  |
| `metadata` | `Map<String, Any?>` | No |  |
| `passcode` | `String` | No |  |
| `sender` | `String` | No |  |
| `template` | `String` | No |  |
| `validity` | `Double` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.oneTimePassword(null).create(mutableMapOf<String, Any?>(
), null)
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```kotlin
val result = client.oneTimePassword(null).load(mutableMapOf<String, Any?>("messageid" to "messageid"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OneTimePassword` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Schedule

```kotlin
val schedule = client.schedule(null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Schedule` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Swagger

```kotlin
val swagger = client.swagger(null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Swagger` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Util

```kotlin
val util = client.util(null)
```

### Operations

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```kotlin
val result = client.util(null).load(mutableMapOf<String, Any?>("errorcode" to "errorcode"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Util` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```kotlin
val feature = mutableMapOf<String, Any?>(
    "test" to mapOf("active" to true),
)
val client = ThesmsworksSDK(mutableMapOf<String, Any?>("feature" to feature))
```

