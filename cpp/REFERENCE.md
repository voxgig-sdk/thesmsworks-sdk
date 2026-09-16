# Thesmsworks C++ SDK Reference

Complete API reference for the Thesmsworks C++ SDK.


## ThesmsworksSDK

### Constructor

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<ThesmsworksSDK>(options);
```

Create a new SDK client instance. `options` is an `sdk::Value` map.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Value` | SDK configuration options (a map). |
| `options["apikey"]` | `std::string` | API key for authentication. |
| `options["base"]` | `std::string` | Base URL for API requests. |
| `options["prefix"]` | `std::string` | URL prefix appended after base. |
| `options["suffix"]` | `std::string` | URL suffix appended after path. |
| `options["headers"]` | `Value` | Custom headers for all requests. |
| `options["feature"]` | `Value` | Feature configuration. |
| `options["system"]` | `Value` | System overrides. |


### Static Methods

#### `ThesmsworksSDK::testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be
`Value::undef()`; a no-arg overload is also provided.

```cpp
auto client = ThesmsworksSDK::testSDK();
```


### Instance Methods

#### `batch(entopts = Value::undef()) -> std::shared_ptr<BatchEntity>`

Create a new `BatchEntity` instance bound to this client.

#### `batch_message(entopts = Value::undef()) -> std::shared_ptr<BatchMessageEntity>`

Create a new `BatchMessageEntity` instance bound to this client.

#### `credit(entopts = Value::undef()) -> std::shared_ptr<CreditEntity>`

Create a new `CreditEntity` instance bound to this client.

#### `flash(entopts = Value::undef()) -> std::shared_ptr<FlashEntity>`

Create a new `FlashEntity` instance bound to this client.

#### `message(entopts = Value::undef()) -> std::shared_ptr<MessageEntity>`

Create a new `MessageEntity` instance bound to this client.

#### `one_time_password(entopts = Value::undef()) -> std::shared_ptr<OneTimePasswordEntity>`

Create a new `OneTimePasswordEntity` instance bound to this client.

#### `schedule(entopts = Value::undef()) -> std::shared_ptr<ScheduleEntity>`

Create a new `ScheduleEntity` instance bound to this client.

#### `swagger(entopts = Value::undef()) -> std::shared_ptr<SwaggerEntity>`

Create a new `SwaggerEntity` instance bound to this client.

#### `util(entopts = Value::undef()) -> std::shared_ptr<UtilEntity>`

Create a new `UtilEntity` instance bound to this client.

#### `optionsMap() -> Value`

Return a deep copy of the current SDK options.

#### `getUtility() -> UtilityPtr`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `getp(result, "ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `std::string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `std::string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Value` | Path parameter values. |
| `fetchargs["query"]` | `Value` | Query string parameters. |
| `fetchargs["headers"]` | `Value` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `Value` (result map)

#### `prepare(fetchargs) -> Value`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## BatchEntity

```cpp
auto batch = client->batch();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `std::string` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->batch()->load(vmap({{"id", Value("batch_id")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `BatchEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## BatchMessageEntity

```cpp
auto batch_message = client->batch_message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `std::string` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `std::string` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `std::vector<Value>` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `std::string` | No | Date-time at which to send the batch. |
| `sender` | `std::string` | Yes | The sender of the message. |
| `tag` | `std::string` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `double` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `double` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->batch_message()->create(vmap({
    {"content", Value("example_content")},  // std::string
    {"destinations", vlist()},  // std::vector<Value>
    {"sender", Value("example_sender")},  // std::string
}), Value::undef());
```

#### `remove(reqmatch, ctrl) -> Value`

Remove the entity matching the given criteria. Throws on error.

```cpp
Value result = client->batch_message()->remove(vmap({{"batchid", Value("batchid")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `BatchMessageEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## CreditEntity

```cpp
auto credit = client->credit();
```

### Operations

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->credit()->load(Value::undef(), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `CreditEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## FlashEntity

```cpp
auto flash = client->flash();
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `FlashEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## MessageEntity

```cpp
auto message = client->message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `credits` | `double` | No | The number of credits used on the message. |
| `destination` | `std::string` | No | The phone number of the recipient. |
| `from` | `std::string` | No | The date-time from which you would like matching messages |
| `id` | `std::string` | No |  |
| `keyword` | `std::string` | No | The keyword used in the inbound message |
| `limit` | `double` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `std::map<std::string, Value>` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `std::string` | No | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `double` | No | The number of results you would like to ignore before returning messages. |
| `status` | `std::string` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `std::string` | No | The date-time to which you would like matching messages |
| `unread` | `bool` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->message()->create(vmap({
}), Value::undef());
```

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->message()->load(vmap({{"id", Value("message_id")}}), Value::undef());
```

#### `remove(reqmatch, ctrl) -> Value`

Remove the entity matching the given criteria. Throws on error.

```cpp
Value result = client->message()->remove(vmap({{"id", Value("message_id")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `MessageEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## OneTimePasswordEntity

```cpp
auto one_time_password = client->one_time_password();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `std::string` | No | The phone number of the recipient. |
| `length` | `std::map<std::string, Value>` | No | The length of the generated passcode. |
| `metadata` | `std::map<std::string, Value>` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `std::string` | No | A passcode you supply for use in the message template. |
| `sender` | `std::string` | No | The sender of the message. |
| `template` | `std::string` | No | A template to use as the content for the message. |
| `validity` | `double` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->one_time_password()->create(vmap({
}), Value::undef());
```

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->one_time_password()->load(vmap({{"messageid", Value("messageid")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `OneTimePasswordEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ScheduleEntity

```cpp
auto schedule = client->schedule();
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ScheduleEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SwaggerEntity

```cpp
auto swagger = client->swagger();
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SwaggerEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## UtilEntity

```cpp
auto util = client->util();
```

### Operations

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->util()->load(vmap({{"errorcode", Value("errorcode")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `UtilEntity` instance with the same options.

#### `getName() -> std::string`

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

```cpp
auto client = std::make_shared<ThesmsworksSDK>(vmap({
    {"feature", vmap({
        {"debug", vmap({{"active", Value(true)}})},
        {"idempotency", vmap({{"active", Value(true)}})},
        {"metrics", vmap({{"active", Value(true)}})},
        {"paging", vmap({{"active", Value(true)}})},
        {"ratelimit", vmap({{"active", Value(true)}})},
        {"retry", vmap({{"active", Value(true)}})},
        {"test", vmap({{"active", Value(true)}})},
        {"timeout", vmap({{"active", Value(true)}})},
    })},
}));
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

