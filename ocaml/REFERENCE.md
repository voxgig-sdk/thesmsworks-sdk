# Thesmsworks OCaml SDK Reference

Complete API reference for the Thesmsworks OCaml SDK.


## Sdk_client

### Constructor

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make options
```

Create a new SDK client instance from a `value` options map. Use
`Sdk_client.make0 ()` for defaults.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `value` | SDK configuration options (a Map). |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Static constructors

#### `Sdk_client.test testopts sdkopts`

Create a test client with mock features active. Both arguments may be `Noval`
(`Sdk_client.test ()` uses defaults, `Sdk_client.test_with` takes explicit
options).

```ocaml
let client = Sdk_client.test ()
```


### Instance functions

#### `Sdk_client.batch client entopts : entity_obj`

Create a `Batch` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.batch_message client entopts : entity_obj`

Create a `BatchMessage` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.credit client entopts : entity_obj`

Create a `Credit` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.flash client entopts : entity_obj`

Create a `Flash` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.message client entopts : entity_obj`

Create a `Message` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.one_time_password client entopts : entity_obj`

Create a `OneTimePassword` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.schedule client entopts : entity_obj`

Create a `Schedule` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.swagger client entopts : entity_obj`

Create a `Swagger` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.util client entopts : entity_obj`

Create a `Util` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.direct client fetchargs : value`

Make a direct HTTP request to any API endpoint. Returns a result `value` map
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch never raises — branch on `getp result "ok"`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `value` | Request body (Maps are JSON-serialized). |

**Returns:** a result `value` map.

#### `Sdk_client.prepare client fetchargs : value`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## Batch

```ocaml
let batch = Sdk_client.batch client Noval
```

### Operations

#### `e_load reqmatch ctrl : value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```ocaml
let result = (Sdk_client.batch client Noval).e_load (jo [("id", (Str "batch_id"))]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Batch` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## BatchMessage

```ocaml
let batch_message = Sdk_client.batch_message client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `value list` | Yes |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `tag` | `string` | No |  |
| `ttl` | `float` | No |  |
| `validity` | `float` | No |  |

### Operations

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.batch_message client Noval).e_create (jo [
    ("content", (Str "example_content"));  (* string *)
    ("destination", (empty_list ()));  (* value list *)
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
```

#### `e_remove reqmatch ctrl : value`

Remove the entity matching the given criteria. Raises on error.

```ocaml
let result = (Sdk_client.batch_message client Noval).e_remove (jo [("batchid", (Str "batchid"))]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `BatchMessage` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Credit

```ocaml
let credit = Sdk_client.credit client Noval
```

### Operations

#### `e_load reqmatch ctrl : value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```ocaml
let result = (Sdk_client.credit client Noval).e_load (Noval) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Credit` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Flash

```ocaml
let flash = Sdk_client.flash client Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Flash` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Message

```ocaml
let message = Sdk_client.message client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `credit` | `float` | No |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `string` | Yes |  |
| `from` | `string` | No |  |
| `keyword` | `string` | No |  |
| `limit` | `float` | No |  |
| `metadata` | `value map` | No |  |
| `responseemail` | `value list` | No |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `skip` | `float` | No |  |
| `status` | `string` | No |  |
| `tag` | `string` | No |  |
| `to` | `string` | No |  |
| `ttl` | `float` | No |  |
| `unread` | `bool` | No |  |
| `validity` | `float` | No |  |

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

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.message client Noval).e_create (jo [
    ("content", (Str "example_content"));  (* string *)
    ("destination", (Str "example_destination"));  (* string *)
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
```

#### `e_load reqmatch ctrl : value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```ocaml
let result = (Sdk_client.message client Noval).e_load (jo [("id", (Str "message_id"))]) Noval
```

#### `e_remove reqmatch ctrl : value`

Remove the entity matching the given criteria. Raises on error.

```ocaml
let result = (Sdk_client.message client Noval).e_remove (jo [("id", (Str "message_id"))]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Message` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## OneTimePassword

```ocaml
let one_time_password = Sdk_client.one_time_password client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `string` | No |  |
| `length` | `value map` | No |  |
| `metadata` | `value map` | No |  |
| `passcode` | `string` | No |  |
| `sender` | `string` | No |  |
| `template` | `string` | No |  |
| `validity` | `float` | No |  |

### Operations

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.one_time_password client Noval).e_create (jo [
]) Noval
```

#### `e_load reqmatch ctrl : value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```ocaml
let result = (Sdk_client.one_time_password client Noval).e_load (jo [("messageid", (Str "messageid"))]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `OneTimePassword` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Schedule

```ocaml
let schedule = Sdk_client.schedule client Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Schedule` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Swagger

```ocaml
let swagger = Sdk_client.swagger client Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Swagger` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Util

```ocaml
let util = Sdk_client.util client Noval
```

### Operations

#### `e_load reqmatch ctrl : value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```ocaml
let result = (Sdk_client.util client Noval).e_load (jo [("errorcode", (Str "errorcode"))]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Util` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ocaml
let client = Sdk_client.make (jo [
    ("feature", jo [
        ("test", jo [("active", Bool true)]);
    ]);
])
```

