# Thesmsworks Clojure SDK Reference

Complete API reference for the Thesmsworks Clojure SDK.


## Client

### make-sdk

```clojure
(require '[sdk.api :as api]
         '[voxgig.struct :as vs])

(def client (api/make-sdk options))
```

Create a new SDK client instance. `options` is a `voxgig.struct` map.

**Options:**

| Key | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Test client

#### `(api/test-sdk testopts sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```clojure
(def client (api/test-sdk nil nil))
```


### Client functions

#### `(api/batch client data)`

Create a new `Batch` entity instance. Pass `nil` for no initial data.

#### `(api/batch_message client data)`

Create a new `BatchMessage` entity instance. Pass `nil` for no initial data.

#### `(api/credit client data)`

Create a new `Credit` entity instance. Pass `nil` for no initial data.

#### `(api/flash client data)`

Create a new `Flash` entity instance. Pass `nil` for no initial data.

#### `(api/message client data)`

Create a new `Message` entity instance. Pass `nil` for no initial data.

#### `(api/one_time_password client data)`

Create a new `OneTimePassword` entity instance. Pass `nil` for no initial data.

#### `(api/schedule client data)`

Create a new `Schedule` entity instance. Pass `nil` for no initial data.

#### `(api/swagger client data)`

Create a new `Swagger` entity instance. Pass `nil` for no initial data.

#### `(api/util client data)`

Create a new `Util` entity instance. Pass `nil` for no initial data.

#### `(api/options-map client) -> map`

Return a deep copy of the current SDK options.

#### `(api/get-utility client) -> utility`

Return a copy of the SDK utility object.

#### `(api/direct client fetchargs) -> map`

Make a direct HTTP request to any API endpoint. Returns a result `map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `(vs/getprop result "ok")`.

**Fetch args:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

**Returns:** a result `map`.

#### `(api/prepare client fetchargs) -> map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Batch

```clojure
(require '[sdk.entity.batch :as e-batch])

(def batch (api/batch client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-batch/load (api/batch client nil) (vs/jm "id" "batch_id") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Batch` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## BatchMessage

```clojure
(require '[sdk.entity.batch_message :as e-batch_message])

(def batch_message (api/batch_message client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `string` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `vector` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `string` | No | Date-time at which to send the batch. |
| `sender` | `string` | Yes | The sender of the message. |
| `tag` | `string` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `double` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `double` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-batch_message/create (api/batch_message client nil)
    (vs/jm
      "content" "example_content"  ;; string
      "destinations" (vs/jt)  ;; vector
      "sender" "example_sender"  ;; string
      )
    nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-batch_message/remove (api/batch_message client nil) (vs/jm "batchid" "batchid") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `BatchMessage` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Credit

```clojure
(require '[sdk.entity.credit :as e-credit])

(def credit (api/credit client nil))
```

### Operations

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-credit/load (api/credit client nil) nil nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Credit` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Flash

```clojure
(require '[sdk.entity.flash :as e-flash])

(def flash (api/flash client nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Flash` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Message

```clojure
(require '[sdk.entity.message :as e-message])

(def message (api/message client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `credits` | `double` | No | The number of credits used on the message. |
| `destination` | `string` | No | The phone number of the recipient. |
| `from` | `string` | No | The date-time from which you would like matching messages |
| `id` | `string` | No |  |
| `keyword` | `string` | No | The keyword used in the inbound message |
| `limit` | `double` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `map` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `string` | No | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `double` | No | The number of results you would like to ignore before returning messages. |
| `status` | `string` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `string` | No | The date-time to which you would like matching messages |
| `unread` | `boolean` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-message/create (api/message client nil)
    (vs/jm
      )
    nil))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-message/load (api/message client nil) (vs/jm "id" "message_id") nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-message/remove (api/message client nil) (vs/jm "id" "message_id") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Message` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## OneTimePassword

```clojure
(require '[sdk.entity.one_time_password :as e-one_time_password])

(def one_time_password (api/one_time_password client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `string` | No | The phone number of the recipient. |
| `length` | `map` | No | The length of the generated passcode. |
| `metadata` | `map` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `string` | No | A passcode you supply for use in the message template. |
| `sender` | `string` | No | The sender of the message. |
| `template` | `string` | No | A template to use as the content for the message. |
| `validity` | `double` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-one_time_password/create (api/one_time_password client nil)
    (vs/jm
      )
    nil))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-one_time_password/load (api/one_time_password client nil) (vs/jm "messageid" "messageid") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `OneTimePassword` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Schedule

```clojure
(require '[sdk.entity.schedule :as e-schedule])

(def schedule (api/schedule client nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Schedule` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Swagger

```clojure
(require '[sdk.entity.swagger :as e-swagger])

(def swagger (api/swagger client nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Swagger` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Util

```clojure
(require '[sdk.entity.util :as e-util])

(def util (api/util client nil))
```

### Operations

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-util/load (api/util client nil) (vs/jm "errorcode" "errorcode") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Util` entity instance with the same options.

#### `((:get-name ent)) -> string`

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

```clojure
(def client
  (api/make-sdk
    (vs/jm "feature"
      (vs/jm
        "debug" (vs/jm "active" true)
        "idempotency" (vs/jm "active" true)
        "metrics" (vs/jm "active" true)
        "paging" (vs/jm "active" true)
        "ratelimit" (vs/jm "active" true)
        "retry" (vs/jm "active" true)
        "test" (vs/jm "active" true)
        "timeout" (vs/jm "active" true)
        ))))
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

