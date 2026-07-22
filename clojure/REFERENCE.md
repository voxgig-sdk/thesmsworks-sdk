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
| `ai` | `boolean` | No |  |
| `content` | `string` | Yes |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `vector` | Yes |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `tag` | `string` | No |  |
| `ttl` | `double` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-batch_message/create (api/batch_message client nil)
    (vs/jm
      "content" "example_content"  ;; string
      "destination" (vs/jt)  ;; vector
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
| `ai` | `boolean` | No |  |
| `content` | `string` | Yes |  |
| `credit` | `double` | No |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `string` | Yes |  |
| `from` | `string` | No |  |
| `keyword` | `string` | No |  |
| `limit` | `double` | No |  |
| `metadata` | `map` | No |  |
| `responseemail` | `vector` | No |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `skip` | `double` | No |  |
| `status` | `string` | No |  |
| `tag` | `string` | No |  |
| `to` | `string` | No |  |
| `ttl` | `double` | No |  |
| `unread` | `boolean` | No |  |
| `validity` | `double` | No |  |

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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-message/create (api/message client nil)
    (vs/jm
      "content" "example_content"  ;; string
      "destination" "example_destination"  ;; string
      "sender" "example_sender"  ;; string
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
| `destination` | `string` | No |  |
| `length` | `map` | No |  |
| `metadata` | `map` | No |  |
| `passcode` | `string` | No |  |
| `sender` | `string` | No |  |
| `template` | `string` | No |  |
| `validity` | `double` | No |  |

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
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```clojure
(def client
  (api/make-sdk
    (vs/jm "feature"
      (vs/jm
        "test" (vs/jm "active" true)
        ))))
```

