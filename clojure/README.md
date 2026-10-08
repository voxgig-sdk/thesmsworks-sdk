# Thesmsworks Clojure SDK



The Clojure SDK for the Thesmsworks API — an entity-oriented client
following idiomatic Clojure conventions (plain functions, immutable data, and
the vendored `voxgig.struct` value model).

The SDK exposes the API as capitalised, semantic **Entities** — for example `(api/batch client nil)` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Clojars. Depend on it directly from the
GitHub release tag (`clojure/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/thesmsworks-sdk/tags)),
using a `tools.deps` git dependency:

```clojure
;; deps.edn
{:deps {thesmsworks/sdk
        {:git/url "https://github.com/voxgig-sdk/thesmsworks-sdk"
         :git/tag "clojure/vX.Y.Z"
         :git/sha "..."
         :deps/root "clojure"}}}
```

Or from a local source checkout:

```clojure
;; deps.edn
{:deps {thesmsworks/sdk {:local/root "../clojure"}}}
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```clojure
(require '[sdk.api :as api]
         '[sdk.entity.batch :as e-batch]
         '[voxgig.struct :as vs])

(def client (api/make-sdk (vs/jm "apikey" (System/getenv "THESMSWORKS_APIKEY"))))
```

### 3. Load a batch

`load` returns the entity and raises on error; `((:data-get batch))` reads
its record.

```clojure
(try
  (let [batch (e-batch/load (api/batch client nil) (vs/jm "id" "example_id") nil)]
    (println ((:data-get batch))))
  (catch Exception err
    (println "load failed:" (.getMessage err))))
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const batch = await client.Batch().load({ id: "example_id" })
  console.log(batch.data())
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
result envelope. Branch on `ok`; on failure `status` holds the HTTP status
(for error responses) and `err` holds the error:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (!result.ok) {
  console.error('request failed:', result.status, result.err)
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity operations:

```clojure
(def result
  (api/direct client
    (vs/jm "path" "/api/resource/{id}"
           "method" "GET"
           "params" (vs/jm "id" "example"))))

(if (vs/getprop result "ok")
  (do
    (println (vs/getprop result "status"))  ;; 200
    (println (vs/getprop result "data")))   ;; response body
  ;; A non-2xx response carries status + data (the error body); a
  ;; transport-level failure carries err instead. Only one is present.
  (println (vs/getprop result "status") (vs/getprop result "err")))
```

### Prepare a request without sending it

```clojure
;; prepare returns the fetch definition and raises on error.
(def fetchdef
  (api/prepare client
    (vs/jm "path" "/api/resource/{id}"
           "method" "DELETE"
           "params" (vs/jm "id" "example"))))

(println (vs/getprop fetchdef "url"))
(println (vs/getprop fetchdef "method"))
(println (vs/getprop fetchdef "headers"))
```

### Use test mode

Create a mock client for unit testing — no server required:

```clojure
(require '[sdk.api :as api]
         '[sdk.entity.batch :as e-batch]
         '[voxgig.struct :as vs])

(def client (api/test-sdk nil nil))

;; Entity ops return the entity; they raise on error.
(def batch (e-batch/load (api/batch client nil) (vs/jm "id" "test01") nil))
;; ((:data-get batch)) reads the entity's mock record
(println ((:data-get batch)))
```

### Use a custom fetch function

Replace the HTTP transport with your own function. A fetch fn takes the
URL and fetch definition and returns a `[response err]` pair; `response`
is a struct map carrying `status`, `headers`, and a `json` thunk:

```clojure
(defn mock-fetch [url fetchdef]
  [(vs/jm "status" 200
          "statusText" "OK"
          "headers" (vs/jm)
          "json" (fn [] (vs/jm "id" "mock01")))
   nil])

(def client
  (api/make-sdk
    (vs/jm "base" "http://localhost:8080"
           "system" (vs/jm "fetch" mock-fetch))))
```

### Run the test suite

The generated suite (pipeline, features, netsim, primary utility and the
vendored struct corpus) runs offline through a single `tools.deps` entry
point:

```bash
cd clojure && make test
```

To exercise the SDK against the live API, construct a client with real
credentials and call its operations directly.


## Reference

### make-sdk

```clojure
(require '[sdk.api :as api]
         '[voxgig.struct :as vs])

(def client (api/make-sdk options))
```

Creates a new SDK client. `options` is a `voxgig.struct` map (or `nil`).

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `extend` | `vector` | Additional feature atoms to load. |
| `system` | `map` | System overrides (e.g. custom `fetch` fn). |

### test-sdk

```clojure
(def client (api/test-sdk testopts sdkopts))
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### Client functions

| Function | Signature | Description |
| --- | --- | --- |
| `options-map` | `(client) -> map` | Deep copy of current SDK options. |
| `get-utility` | `(client) -> utility` | Copy of the SDK utility object. |
| `prepare` | `(client fetchargs) -> map` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(client fetchargs) -> map` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `batch` | `(client data) -> Batch entity` | Create a Batch entity instance. |
| `batch_message` | `(client data) -> BatchMessage entity` | Create a BatchMessage entity instance. |
| `credit` | `(client data) -> Credit entity` | Create a Credit entity instance. |
| `message` | `(client data) -> Message entity` | Create a Message entity instance. |
| `message_message` | `(client data) -> MessageMessage entity` | Create a MessageMessage entity instance. |
| `message_schedule` | `(client data) -> MessageSchedule entity` | Create a MessageSchedule entity instance. |
| `one_time_password` | `(client data) -> OneTimePassword entity` | Create an OneTimePassword entity instance. |
| `schedule` | `(client data) -> Schedule entity` | Create a Schedule entity instance. |
| `util` | `(client data) -> Util entity` | Create an Util entity instance. |

### Entity interface

All entities share the same interface. Operations are functions in the
entity namespace (`sdk.entity.<name>`); state accessors are stored on the
entity map and are called via keyword lookup.

| Member | Signature | Description |
| --- | --- | --- |
| `load` | `(ent reqmatch ctrl) -> entity` | Load a single entity by match criteria, and return it. Raises on error. |
| `create` | `(ent reqdata ctrl) -> entity` | Create a new entity, and return it. Raises on error. |
| `remove` | `(ent reqmatch ctrl) -> entity` | Remove an entity, and return it marked as deleted. Raises on error. |
| `:data-get` | `() -> map` | Get entity data. |
| `:data-set` | `(data)` | Set entity data. |
| `:match-get` | `() -> map` | Get entity match criteria. |
| `:match-set` | `(match)` | Set entity match criteria. |
| `:make` | `() -> entity` | Create a new instance with the same options. |
| `:get-name` | `() -> string` | Return the entity name. |

State accessors are called by looking up the fn and applying it, e.g.
`((:data-get ent))` or `((:data-set ent) (vs/jm "k" "v"))`.

### Result shape

Entity operations resolve to the entity, and `list` to a `vector` of
entities, one per record. Read an entity's record with
`((:data-get ent))`. They raise (via `ex-info`) on error, so wrap calls
in `try`/`catch` to handle failures.

The `direct` escape hatch never raises — it returns a result `map` you
branch on via `(vs/getprop result "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean` | `true` if the HTTP status is 2xx. |
| `status` | `long` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Batch

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Load.

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

Operations: Create.

API path: `/batch/any`

#### Credit

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/credits/balance`

#### Message

| Field | Description |
| --- | --- |

Operations: Create.

API path: `/messages/failed`

#### MessageMessage

| Field | Description |
| --- | --- |
| `credits` | The number of credits used on the message. |
| `destination` | The phone number of the recipient. |
| `from` | The date-time from which you would like matching messages |
| `id` |  |
| `keyword` | The keyword used in the inbound message |
| `limit` | The maximum number of messages that you would like returned in this call. |
| `metadata` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | The number of results you would like to ignore before returning messages. |
| `status` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | The date-time to which you would like matching messages |
| `unread` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

Operations: Create, Load, Remove.

API path: `/messages`

#### MessageSchedule

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Load, Remove.

API path: `/messages/schedule`

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

Operations: Create, Load.

API path: `/otp/send`

#### Schedule

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Remove.

API path: `/batches/schedule/{batchid}`

#### Util

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/utils/errors/{errorcode}`



## Entities


### Batch

Create an instance: `(def batch (api/batch client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(load ent match ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |

#### Example: Load

```clojure
(def batch (e-batch/load (api/batch client nil) (vs/jm "id" "batch_id") nil))
```


### BatchMessage

Create an instance: `(def batch_message (api/batch_message client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(create ent data ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Message to send to the recipient |
| `deliveryreporturl` | `string` | The url to which we should POST delivery reports to for this message. |
| `destinations` | `vector` | Telephone numbers of each of the recipients |
| `schedule` | `string` | Date-time at which to send the batch. |
| `sender` | `string` | The sender of the message. |
| `tag` | `string` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `double` | The number of minutes before the delivery report is deleted. |
| `validity` | `double` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Create

```clojure
(def batch_message
  (e-batch_message/create (api/batch_message client nil)
    (vs/jm
      "content" "example_content"  ;; string
      "destinations" (vs/jt)  ;; vector
      "sender" "example_sender"  ;; string
      )
    nil))
```


### Credit

Create an instance: `(def credit (api/credit client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(load ent match ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```clojure
(def credit (e-credit/load (api/credit client nil) nil nil))
```


### Message

Create an instance: `(def message (api/message client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(create ent data ctrl)` | Create a new entity with the given data. |


### MessageMessage

Create an instance: `(def message_message (api/message_message client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(create ent data ctrl)` | Create a new entity with the given data. |
| `(load ent match ctrl)` | Load a single entity by match criteria. |
| `(remove ent match ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `credits` | `double` | The number of credits used on the message. |
| `destination` | `string` | The phone number of the recipient. |
| `from` | `string` | The date-time from which you would like matching messages |
| `id` | `string` |  |
| `keyword` | `string` | The keyword used in the inbound message |
| `limit` | `double` | The maximum number of messages that you would like returned in this call. |
| `metadata` | `map` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `string` | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `double` | The number of results you would like to ignore before returning messages. |
| `status` | `string` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `string` | The date-time to which you would like matching messages |
| `unread` | `boolean` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

#### Example: Load

```clojure
(def message_message (e-message_message/load (api/message_message client nil) (vs/jm "id" "message_message_id") nil))
```

#### Example: Create

```clojure
(def message_message
  (e-message_message/create (api/message_message client nil)
    (vs/jm
      )
    nil))
```


### MessageSchedule

Create an instance: `(def message_schedule (api/message_schedule client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(load ent match ctrl)` | Load a single entity by match criteria. |
| `(remove ent match ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |

#### Example: Load

```clojure
(def message_schedule (e-message_schedule/load (api/message_schedule client nil) (vs/jm "id" "message_schedule_id") nil))
```


### OneTimePassword

Create an instance: `(def one_time_password (api/one_time_password client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(create ent data ctrl)` | Create a new entity with the given data. |
| `(load ent match ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `string` | The phone number of the recipient. |
| `length` | `map` | The length of the generated passcode. |
| `metadata` | `map` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `string` | A passcode you supply for use in the message template. |
| `sender` | `string` | The sender of the message. |
| `template` | `string` | A template to use as the content for the message. |
| `validity` | `double` | The length of time in seconds for which the generated passcode should be valid. |

#### Example: Load

```clojure
(def one_time_password (e-one_time_password/load (api/one_time_password client nil) (vs/jm "messageid" "messageid") nil))
```

#### Example: Create

```clojure
(def one_time_password
  (e-one_time_password/create (api/one_time_password client nil)
    (vs/jm
      )
    nil))
```


### Schedule

Create an instance: `(def schedule (api/schedule client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(remove ent match ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |


### Util

Create an instance: `(def util (api/util client nil))`

#### Operations

| Method | Description |
| --- | --- |
| `(load ent match ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```clojure
(def util (e-util/load (api/util client nil) (vs/jm "errorcode" "errorcode") nil))
```

## Features

This SDK ships 20 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`audit`](#audit) | Audit trail |
| [`cache`](#cache) | Response cache |
| [`clienttrack`](#clienttrack) | Client tracking |
| [`cost`](#cost) | Cost tracking |
| [`debug`](#debug) | Debug capture |
| [`idempotency`](#idempotency) | Idempotency |
| [`log`](#log) | Logging |
| [`metrics`](#metrics) | Metrics |
| [`netsim`](#netsim) | Network simulation |
| [`paging`](#paging) | Paging |
| [`proxy`](#proxy) | Proxy |
| [`ratelimit`](#ratelimit) | Rate limiting |
| [`rbac`](#rbac) | Access control |
| [`retry`](#retry) | Retry |
| [`secrets`](#secrets) | Secrets |
| [`streaming`](#streaming) | Streaming |
| [`telemetry`](#telemetry) | Telemetry |
| [`test`](#test) | Test transport |
| [`timeout`](#timeout) | Timeout |
| [`validate`](#validate) | Validation |

> **Order matters for `cache`, `cost`, `netsim`, `proxy`, `ratelimit`, `retry`, `secrets`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### audit

Audit trail.

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

Set `feature.audit.active` to enable it, then override any of the options above.

### cache

Response cache.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `256` |
| `methods` | `['GET']` |
| `ttl` | `5000` |

Set `feature.cache.active` to enable it, then override any of the options above.

`cache` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### clienttrack

Client tracking.

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

Set `feature.clienttrack.active` to enable it, then override any of the options above.

### cost

Cost tracking.

| Option | Default |
|---|---|
| `active` | `false` |
| `budget` | `0` |
| `currency` | `'USD'` |
| `header` | `''` |
| `onBudget` | `'warn'` |
| `path` | `''` |
| `perUnit` | `0` |
| `rates` | `{}` |
| `unit` | `0` |

Set `feature.cost.active` to enable it, then override any of the options above.

`cost` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### debug

Debug capture.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

Set `feature.debug.active` to enable it, then override any of the options above.

### idempotency

Idempotency.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### log

Logging.

| Option | Default |
|---|---|
| `active` | `true` |

Set `feature.log.active` to enable it, then override any of the options above.

### metrics

Metrics.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### netsim

Network simulation.

| Option | Default |
|---|---|
| `active` | `false` |
| `errorTimes` | `0` |
| `failEvery` | `0` |
| `failRate` | `0` |
| `failStatus` | `503` |
| `failTimes` | `0` |
| `latency` | `0` |
| `offline` | `false` |
| `rateLimitTimes` | `0` |
| `retryAfter` | `0` |
| `seed` | `1` |

Set `feature.netsim.active` to enable it, then override any of the options above.

`netsim` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### paging

Paging.

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Set `feature.paging.active` to enable it, then override any of the options above.

### proxy

Proxy.

| Option | Default |
|---|---|
| `active` | `false` |
| `fromEnv` | `false` |
| `noProxy` | `[]` |
| `url` | `''` |

Set `feature.proxy.active` to enable it, then override any of the options above.

`proxy` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### ratelimit

Rate limiting.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### rbac

Access control.

| Option | Default |
|---|---|
| `active` | `false` |
| `deny` | `false` |
| `permissions` | `[]` |
| `rules` | `{}` |

Set `feature.rbac.active` to enable it, then override any of the options above.

### retry

Retry.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### secrets

Secrets.

| Option | Default |
|---|---|
| `active` | `false` |
| `cache` | `true` |
| `exchange` | `{active: false, method: 'POST', path: 'auth/token', refresh: '', request: 'refresh_token', response: 'access_token', retries: 1, statuses: [401]}` |
| `name` | `'apikey'` |
| `providers` | `[]` |

Set `feature.secrets.active` to enable it, then override any of the options above.

`secrets` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### streaming

Streaming.

| Option | Default |
|---|---|
| `active` | `false` |
| `chunkDelay` | `0` |
| `chunkSize` | `0` |

Set `feature.streaming.active` to enable it, then override any of the options above.

### telemetry

Telemetry.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.telemetry.active` to enable it, then override any of the options above.

### test

Test transport.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Timeout.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### validate

Validation.

| Option | Default |
|---|---|
| `active` | `false` |
| `mode` | `'throw'` |
| `request` | `true` |
| `response` | `false` |
| `strict` | `false` |

Set `feature.validate.active` to enable it, then override any of the options above.


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

- **AuditFeature**: Audit trail
- **CacheFeature**: Response cache
- **ClienttrackFeature**: Client tracking
- **CostFeature**: Cost tracking
- **DebugFeature**: Debug capture
- **IdempotencyFeature**: Idempotency
- **LogFeature**: Logging
- **MetricsFeature**: Metrics
- **NetsimFeature**: Network simulation
- **PagingFeature**: Paging
- **ProxyFeature**: Proxy
- **RatelimitFeature**: Rate limiting
- **RbacFeature**: Access control
- **RetryFeature**: Retry
- **SecretsFeature**: Secrets
- **StreamingFeature**: Streaming
- **TelemetryFeature**: Telemetry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout
- **ValidateFeature**: Validation

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as struct value maps

The Clojure SDK represents API data with the vendored `voxgig.struct`
value model (ordered, Java-backed maps and lists) rather than typed
records. This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with `(vs/jm "k" v ...)` and lists with
`(vs/jt v ...)`; read values with `(vs/getprop m "k")`. Use
`(vs/ismap x)` to safely check that a value is a map.

### Namespace structure

```
clojure/
├── src/sdk/api.clj        -- public API namespace (entity accessors)
├── src/sdk/client.clj     -- client constructors (make-sdk, test-sdk)
├── src/sdk/config.clj     -- generated configuration
├── src/sdk/schema.clj     -- generated option + entity specs
├── src/sdk/core.clj       -- core types, context and pipeline
├── src/sdk/features.clj   -- feature factory
├── src/sdk/entity/        -- entity namespaces (one per entity)
├── src/voxgig/struct.clj  -- vendored struct value library
└── test/                  -- test suites
```

Require `[sdk.api :as api]` for the public surface, and an entity
namespace (e.g. `[sdk.entity.thesmsworks :as e-thesmsworks]`)
only when you call its operations directly.

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
