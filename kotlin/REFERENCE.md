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

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String?` | No |  |

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
| `ai` | `Boolean?` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String?` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `String?` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `List<Any?>?` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `String?` | No | Date-time at which to send the batch. |
| `sender` | `String?` | Yes | The sender of the message. |
| `tag` | `String?` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `Double?` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `Double?` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.batchMessage(null).create(mutableMapOf<String, Any?>(
    "content" to "example_content",  // String?
    "destinations" to listOf<Any?>(),  // List<Any?>?
    "sender" to "example_sender"  // String?
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
| `ai` | `Boolean?` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String?` | Yes | Message to send to the recipient. |
| `credits` | `Double?` | No | The number of credits used on the message. |
| `deliveryreporturl` | `String?` | No | The url to which we should POST delivery reports to for this message. |
| `destination` | `String?` | Yes | Telephone number of the recipient |
| `from` | `String?` | No | The date-time from which you would like matching messages |
| `id` | `String?` | No |  |
| `keyword` | `String?` | No | The keyword used in the inbound message |
| `limit` | `Double?` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Map<String, Any?>?` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `List<Any?>?` | No | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `String?` | No | Date at which to send the message. |
| `sender` | `String?` | Yes | The sender of the message. |
| `skip` | `Double?` | No | The number of results you would like to ignore before returning messages. |
| `status` | `String?` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `String?` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `String?` | No | The date-time to which you would like matching messages |
| `ttl` | `Double?` | No | The optional number of minutes before the delivery report is deleted. |
| `unread` | `Boolean?` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `Double?` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Field Usage by Operation

| Field | load | create | remove |
| --- | --- | --- | --- |
| `ai` | - | - | - |
| `content` | - | - | - |
| `credits` | - | - | - |
| `deliveryreporturl` | - | - | - |
| `destination` | - | Yes | - |
| `from` | - | - | - |
| `id` | - | - | - |
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
    "content" to "example_content",  // String?
    "destination" to "example_destination",  // String?
    "sender" to "example_sender"  // String?
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
| `destination` | `String?` | No | The phone number of the recipient. |
| `length` | `Map<String, Any?>?` | No | The length of the generated passcode. |
| `metadata` | `Map<String, Any?>?` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String?` | No | A passcode you supply for use in the message template. |
| `sender` | `String?` | No | The sender of the message. |
| `template` | `String?` | No | A template to use as the content for the message. |
| `validity` | `Double?` | No | The length of time in seconds for which the generated passcode should be valid. |

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


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### `test`

In-memory mock transport for testing without a live server.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

