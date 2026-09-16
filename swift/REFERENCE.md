# Thesmsworks Swift SDK Reference

Complete API reference for the Thesmsworks Swift SDK.


## ThesmsworksSDK

### Constructor

```swift
let client = ThesmsworksSDK(options)
```

Create a new SDK client instance. `options` is a `VMap` of `Value`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `VMap` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `VMap` | Custom headers for all requests. |
| `options["feature"]` | `VMap` | Feature configuration. |
| `options["system"]` | `VMap` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```swift
let client = ThesmsworksSDK.testSDK(nil, nil)
```


### Instance Methods

#### `Batch(entopts)`

Create a new `Batch` entity instance. Pass `nil` for no initial
options.

#### `BatchMessage(entopts)`

Create a new `BatchMessage` entity instance. Pass `nil` for no initial
options.

#### `Credit(entopts)`

Create a new `Credit` entity instance. Pass `nil` for no initial
options.

#### `Flash(entopts)`

Create a new `Flash` entity instance. Pass `nil` for no initial
options.

#### `Message(entopts)`

Create a new `Message` entity instance. Pass `nil` for no initial
options.

#### `OneTimePassword(entopts)`

Create a new `OneTimePassword` entity instance. Pass `nil` for no initial
options.

#### `Schedule(entopts)`

Create a new `Schedule` entity instance. Pass `nil` for no initial
options.

#### `Swagger(entopts)`

Create a new `Swagger` entity instance. Pass `nil` for no initial
options.

#### `Util(entopts)`

Create a new `Util` entity instance. Pass `nil` for no initial
options.

#### `optionsMap() -> VMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> VMap`

Make a direct HTTP request to any API endpoint. Returns a result `VMap`
with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch never throws — branch on `result.entries["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `VMap` | Path parameter values. |
| `fetchargs["query"]` | `VMap` | Query string parameters. |
| `fetchargs["headers"]` | `VMap` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `VMap`

#### `prepare(fetchargs) throws -> VMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## Batch

```swift
let batch = client.Batch()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Batch().load(VMap([("id", .string("batch_id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Batch` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## BatchMessage

```swift
let batchMessage = client.BatchMessage()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `Bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `String` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `[Value]` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `String` | No | Date-time at which to send the batch. |
| `sender` | `String` | Yes | The sender of the message. |
| `tag` | `String` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `Double` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `Double` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.BatchMessage().create(VMap([
    ("content", .string("example_content")),  // String
    ("destinations", .list([])),  // [Value]
    ("sender", .string("example_sender"))  // String
]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.BatchMessage().remove(VMap([("batchid", .string("batchid"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchMessage` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Credit

```swift
let credit = client.Credit()
```

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Credit().load(nil, nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Credit` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Flash

```swift
let flash = client.Flash()
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Flash` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Message

```swift
let message = client.Message()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `credits` | `Double` | No | The number of credits used on the message. |
| `destination` | `String` | No | The phone number of the recipient. |
| `from` | `String` | No | The date-time from which you would like matching messages |
| `id` | `String` | No |  |
| `keyword` | `String` | No | The keyword used in the inbound message |
| `limit` | `Double` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `VMap` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `String` | No | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `Double` | No | The number of results you would like to ignore before returning messages. |
| `status` | `String` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `String` | No | The date-time to which you would like matching messages |
| `unread` | `Bool` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Message().create(VMap([
]), nil)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Message().load(VMap([("id", .string("message_id"))]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Message().remove(VMap([("id", .string("message_id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Message` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OneTimePassword

```swift
let oneTimePassword = client.OneTimePassword()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No | The phone number of the recipient. |
| `length` | `VMap` | No | The length of the generated passcode. |
| `metadata` | `VMap` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String` | No | A passcode you supply for use in the message template. |
| `sender` | `String` | No | The sender of the message. |
| `template` | `String` | No | A template to use as the content for the message. |
| `validity` | `Double` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.OneTimePassword().create(VMap([
]), nil)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.OneTimePassword().load(VMap([("messageid", .string("messageid"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OneTimePassword` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Schedule

```swift
let schedule = client.Schedule()
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Schedule` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Swagger

```swift
let swagger = client.Swagger()
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Swagger` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Util

```swift
let util = client.Util()
```

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Util().load(VMap([("errorcode", .string("errorcode"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

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

```swift
let feature = VMap()
feature.entries["debug"] = .map([("active", .bool(true))])
feature.entries["idempotency"] = .map([("active", .bool(true))])
feature.entries["metrics"] = .map([("active", .bool(true))])
feature.entries["paging"] = .map([("active", .bool(true))])
feature.entries["ratelimit"] = .map([("active", .bool(true))])
feature.entries["retry"] = .map([("active", .bool(true))])
feature.entries["test"] = .map([("active", .bool(true))])
feature.entries["timeout"] = .map([("active", .bool(true))])
let options = VMap()
options.entries["feature"] = .map(feature)
let client = ThesmsworksSDK(options)
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

