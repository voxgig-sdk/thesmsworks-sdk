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

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.batch client Noval).e_load (jo [("id", (Str "batch_id"))]) Noval
let result_data = result.e_data_get ()
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
| `ai` | `bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `string` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `value list` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `string` | No | Date-time at which to send the batch. |
| `sender` | `string` | Yes | The sender of the message. |
| `tag` | `string` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `float` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `float` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.batch_message client Noval).e_create (jo [
    ("content", (Str "example_content"));  (* string *)
    ("destinations", (empty_list ()));  (* value list *)
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the ENTITY, marked deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.batch_message client Noval).e_remove (jo [("batchid", (Str "batchid"))]) Noval
let result_data = result.e_data_get ()
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

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.credit client Noval).e_load (Noval) Noval
let result_data = result.e_data_get ()
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
| `ai` | `bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Yes | Message to send to the recipient. |
| `credits` | `float` | No | The number of credits used on the message. |
| `deliveryreporturl` | `string` | No | The url to which we should POST delivery reports to for this message. |
| `destination` | `string` | Yes | Telephone number of the recipient |
| `from` | `string` | No | The date-time from which you would like matching messages |
| `id` | `string` | No |  |
| `keyword` | `string` | No | The keyword used in the inbound message |
| `limit` | `float` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `value map` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `value list` | No | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `string` | No | Date at which to send the message. |
| `sender` | `string` | Yes | The sender of the message. |
| `skip` | `float` | No | The number of results you would like to ignore before returning messages. |
| `status` | `string` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `string` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `string` | No | The date-time to which you would like matching messages |
| `ttl` | `float` | No | The optional number of minutes before the delivery report is deleted. |
| `unread` | `bool` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `float` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

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

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.message client Noval).e_create (jo [
    ("content", (Str "example_content"));  (* string *)
    ("destination", (Str "example_destination"));  (* string *)
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
let result_data = result.e_data_get ()
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.message client Noval).e_load (jo [("id", (Str "message_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the ENTITY, marked deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.message client Noval).e_remove (jo [("id", (Str "message_id"))]) Noval
let result_data = result.e_data_get ()
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
| `destination` | `string` | No | The phone number of the recipient. |
| `length` | `value map` | No | The length of the generated passcode. |
| `metadata` | `value map` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `string` | No | A passcode you supply for use in the message template. |
| `sender` | `string` | No | The sender of the message. |
| `template` | `string` | No | A template to use as the content for the message. |
| `validity` | `float` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.one_time_password client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.one_time_password client Noval).e_load (jo [("messageid", (Str "messageid"))]) Noval
let result_data = result.e_data_get ()
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

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `e_data_get`) and raises on error.

```ocaml
let result = (Sdk_client.util client Noval).e_load (jo [("errorcode", (Str "errorcode"))]) Noval
let result_data = result.e_data_get ()
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

