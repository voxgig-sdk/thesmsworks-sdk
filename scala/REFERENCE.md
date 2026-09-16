# Thesmsworks Scala SDK Reference

Complete API reference for the Thesmsworks Scala SDK.


## ThesmsworksSDK

### Constructor

```scala
val client = new ThesmsworksSDK(options)
```

Create a new SDK client instance. `options` is a `java.util.Map[String, Object]`.

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

```scala
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

#### `optionsMap() -> Map`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Map`

Make a direct HTTP request to any API endpoint. Returns a result
`java.util.Map[String, Object]` with `ok`, `status`, `headers`, and
`data` (or `err` on failure). This escape hatch never raises — branch on
`result.get("ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Object` | Request body (maps are JSON-serialized). |

**Returns:** `java.util.Map[String, Object]`

#### `prepare(fetchargs) -> Map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Batch

```scala
val batch = client.batch(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.batch(null).load(java.util.Map.of("id", "batch_id"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Batch` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## BatchMessage

```scala
val batchMessage = client.batchMessage(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `java.lang.Boolean` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `String` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `java.util.List[Object]` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `String` | No | Date-time at which to send the batch. |
| `sender` | `String` | Yes | The sender of the message. |
| `tag` | `String` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `java.lang.Double` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `java.lang.Double` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.batchMessage(null).create(java.util.Map.of(
    "content", "example_content",  // String
    "destinations", java.util.List.of(),  // java.util.List[Object]
    "sender", "example_sender"  // String
), null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.batchMessage(null).remove(java.util.Map.of("batchid", "batchid"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchMessage` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Credit

```scala
val credit = client.credit(null)
```

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.credit(null).load(null, null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Credit` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Flash

```scala
val flash = client.flash(null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Flash` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Message

```scala
val message = client.message(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `credits` | `java.lang.Double` | No | The number of credits used on the message. |
| `destination` | `String` | No | The phone number of the recipient. |
| `from` | `String` | No | The date-time from which you would like matching messages |
| `id` | `String` | No |  |
| `keyword` | `String` | No | The keyword used in the inbound message |
| `limit` | `java.lang.Double` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `java.util.Map[String, Object]` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `String` | No | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `java.lang.Double` | No | The number of results you would like to ignore before returning messages. |
| `status` | `String` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `String` | No | The date-time to which you would like matching messages |
| `unread` | `java.lang.Boolean` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.message(null).create(java.util.Map.of(
), null)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.message(null).load(java.util.Map.of("id", "message_id"), null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.message(null).remove(java.util.Map.of("id", "message_id"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Message` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OneTimePassword

```scala
val oneTimePassword = client.oneTimePassword(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No | The phone number of the recipient. |
| `length` | `java.util.Map[String, Object]` | No | The length of the generated passcode. |
| `metadata` | `java.util.Map[String, Object]` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String` | No | A passcode you supply for use in the message template. |
| `sender` | `String` | No | The sender of the message. |
| `template` | `String` | No | A template to use as the content for the message. |
| `validity` | `java.lang.Double` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.oneTimePassword(null).create(java.util.Map.of(
), null)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.oneTimePassword(null).load(java.util.Map.of("messageid", "messageid"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OneTimePassword` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Schedule

```scala
val schedule = client.schedule(null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Schedule` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Swagger

```scala
val swagger = client.swagger(null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Swagger` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Util

```scala
val util = client.util(null)
```

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.util(null).load(java.util.Map.of("errorcode", "errorcode"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Util` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `debug` | 0.0.1 | Request/response capture ring buffer for debugging |
| `idempotency` | 0.0.1 | Idempotency keys for safe retries of mutating operations |
| `metrics` | 0.0.1 | Statistics capture: per-operation counters and latency |
| `paging` | 0.0.1 | Pagination signals for list operations |
| `ratelimit` | 0.0.1 | Client-side rate limiting via a token bucket |
| `retry` | 0.0.1 | Automatic retry of transient failures with exponential backoff |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |
| `timeout` | 0.0.1 | Per-request timeout with transport abort |


Features are activated via the `feature` option:

```scala
val feature = new java.util.LinkedHashMap[String, Object]()
feature.put("debug", java.util.Map.of("active", true))
feature.put("idempotency", java.util.Map.of("active", true))
feature.put("metrics", java.util.Map.of("active", true))
feature.put("paging", java.util.Map.of("active", true))
feature.put("ratelimit", java.util.Map.of("active", true))
feature.put("retry", java.util.Map.of("active", true))
feature.put("test", java.util.Map.of("active", true))
feature.put("timeout", java.util.Map.of("active", true))
val options = new java.util.LinkedHashMap[String, Object]()
options.put("feature", feature)
val client = new ThesmsworksSDK(options)
```


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### Ordering

`ratelimit`, `retry`, `timeout` wrap the transport. Each
wraps whatever is already installed, so **activation order is nesting order**:
a feature activated later sits OUTSIDE one activated earlier, and sees the call
first.

That decides behaviour, not just sequence: a feature that short-circuits the
call, such as a cache serving a hit, stops every feature nested inside it from
ever seeing that call.

`debug`, `idempotency`, `metrics`, `paging`, `test` attach to pipeline hooks
rather than the transport, so their order does not affect what they observe.

#### `debug`

Request/response capture ring buffer for debugging.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

| Option | Type |
|---|---|
| `now` | function |
| `onEntry` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.debug.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `idempotency`

Idempotency keys for safe retries of mutating operations.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

| Option | Type |
|---|---|
| `keygen` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.idempotency.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `metrics`

Statistics capture: per-operation counters and latency.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `now` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.metrics.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `paging`

Pagination signals for list operations.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

| Option | Type |
|---|---|
| `limit` | number |
| `ops` | list |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.paging.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `ratelimit`

Client-side rate limiting via a token bucket.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

| Option | Type |
|---|---|
| `now` | function |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.ratelimit.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `retry`

Automatic retry of transient failures with exponential backoff.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

| Option | Type |
|---|---|
| `jitter` | boolean |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.retry.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `test`

In-memory mock transport for testing without a live server.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `entity` | map |
| `net` | map |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

#### `timeout`

Per-request timeout with transport abort.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

| Option | Type |
|---|---|
| `clearTimer` | function |
| `setTimer` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.timeout.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

