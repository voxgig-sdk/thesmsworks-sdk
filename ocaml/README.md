# Thesmsworks OCaml SDK



The OCaml SDK for the Thesmsworks API — an entity-oriented client
following idiomatic OCaml conventions (a dependency-free library that compiles
with the stock `ocamlc`).

The SDK exposes the API as capitalised, semantic **Entities** — for example `Sdk_client.batch client Noval` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to the opam registry. Install it from the
GitHub release tag (`ocaml/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases))
or from a source checkout. The SDK is dependency-free and compiles with the
stock `ocamlc` — no opam packages, no dune:

```bash
cd ocaml && make build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make (jo [("apikey", Str (Sys.getenv "THESMSWORKS_APIKEY"))])
```

### 3. Load an one_time_password

OneTimePassword is nested under messageid, so provide the `messageid`.
`e_load` returns the bare record (a `Map`) and raises on error.

```ocaml
(try
   let one_time_password = (Sdk_client.one_time_password client Noval).e_load (jo [("messageid", (Str "example_messageid"))]) Noval in
   print_endline (stringify one_time_password)
 with Sdk_error.E err -> Printf.eprintf "load failed: %s\n" (Sdk_error.message err))
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const batch = await client.Batch().load({ id: "example_id" })
  console.log(batch)
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ocaml
let result = Sdk_client.direct client (jo [
    ("path", Str "/api/resource/{id}");
    ("method", Str "GET");
    ("params", jo [("id", Str "example")]);
]) in
(match getp result "ok" with
 | Bool true ->
   print_endline (stringify (getp result "status"));  (* 200 *)
   print_endline (stringify (getp result "data"))      (* response body *)
 | _ ->
   (* A non-2xx response carries status + data (the error body); a transport
      failure carries err instead. Read whichever is present. *)
   print_endline (stringify (getp result "status"));
   print_endline (stringify (getp result "err")))
```

### Prepare a request without sending it

```ocaml
(* prepare returns the fetch definition and raises on error. *)
let fetchdef = Sdk_client.prepare client (jo [
    ("path", Str "/api/resource/{id}");
    ("method", Str "DELETE");
    ("params", jo [("id", Str "example")]);
]) in
print_endline (stringify (getp fetchdef "url"));
print_endline (stringify (getp fetchdef "method"));
print_endline (stringify (getp fetchdef "headers"))
```

### Use test mode

Create a mock client for unit testing — no server required:

```ocaml
let () =
  let client = Sdk_client.test () in
  (* Entity ops return the bare record and raise on error. *)
  let batch = (Sdk_client.batch client Noval).e_load (jo [("id", Str "test01")]) Noval in
  print_endline (stringify batch)  (* the mock response record *)
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ocaml
let mock_fetch = Func (fun _ _args _ _ ->
    jo [("status", Num 200.); ("statusText", Str "OK"); ("headers", empty_map ());
        ("json", json_thunk (jo [("id", Str "mock01")]))]) in
let client = Sdk_client.make (jo [
    ("base", Str "http://localhost:8080");
    ("system", jo [("fetch", mock_fetch)]);
]) in
ignore client
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd ocaml && make test
```


## Reference

### Sdk_client

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make options
```

Creates a new SDK client from a `value` options map. Use `Sdk_client.make0 ()`
for defaults.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `extend` | `list` | Additional feature instances to load. |
| `system` | `map` | System overrides (e.g. custom `fetch` function). |

### Sdk_client.test

```ocaml
let client = Sdk_client.test_with testopts sdkopts
```

Creates a test-mode client with mock transport. Both arguments may be `Noval`
(`Sdk_client.test ()` uses defaults).

### Sdk_client functions

| Function | Signature | Description |
| --- | --- | --- |
| `make` | `value -> sdk_client` | Construct a client from options. |
| `make0` | `unit -> sdk_client` | Construct a client with defaults. |
| `prepare` | `sdk_client -> value -> value` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `sdk_client -> value -> value` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `batch` | `sdk_client -> value -> entity_obj` | A Batch entity accessor. |
| `batch_message` | `sdk_client -> value -> entity_obj` | A BatchMessage entity accessor. |
| `credit` | `sdk_client -> value -> entity_obj` | A Credit entity accessor. |
| `flash` | `sdk_client -> value -> entity_obj` | A Flash entity accessor. |
| `message` | `sdk_client -> value -> entity_obj` | A Message entity accessor. |
| `one_time_password` | `sdk_client -> value -> entity_obj` | An OneTimePassword entity accessor. |
| `schedule` | `sdk_client -> value -> entity_obj` | A Schedule entity accessor. |
| `swagger` | `sdk_client -> value -> entity_obj` | A Swagger entity accessor. |
| `util` | `sdk_client -> value -> entity_obj` | An Util entity accessor. |

### Entity interface

All entities are `entity_obj` records sharing the same fields.

| Field | Signature | Description |
| --- | --- | --- |
| `e_load` | `value -> value -> value` | Load a single entity by match criteria. Raises on error. |
| `e_create` | `value -> value -> value` | Create a new entity. Raises on error. |
| `e_remove` | `value -> value -> value` | Remove an entity. Raises on error. |
| `e_data_get` | `unit -> value` | Get entity data. |
| `e_data_set` | `value -> unit` | Set entity data. |
| `e_match_get` | `unit -> value` | Get entity match criteria. |
| `e_match_set` | `value -> unit` | Set entity match criteria. |
| `e_make` | `unit -> entity_obj` | Create a new instance with the same options. |
| `e_name` | `string` | The entity name. |

### Result shape

Entity operations return the bare result value (a `Map` for single-entity
ops, a `List` for `e_list`) and raise `Sdk_error.E` on error. Wrap calls
in `try`/`with` to handle failures.

The `direct` escape hatch never raises — it returns a result `value` map
you branch on via `getp result "ok"`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Bool` | `Bool true` if the HTTP status is 2xx. |
| `status` | `Num` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `value` | Parsed JSON response body. |

On error, `ok` is `Bool false` and `err` carries the error value.

### Entities

#### Batch

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/batch/{batchid}`

#### BatchMessage

| Field | Description |
| --- | --- |
| `ai` |  |
| `content` |  |
| `deliveryreporturl` |  |
| `destination` |  |
| `schedule` |  |
| `sender` |  |
| `tag` |  |
| `ttl` |  |
| `validity` |  |

Operations: Create, Remove.

API path: `/batch/any`

#### Credit

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/credits/balance`

#### Flash

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Message

| Field | Description |
| --- | --- |
| `ai` |  |
| `content` |  |
| `credit` |  |
| `deliveryreporturl` |  |
| `destination` |  |
| `from` |  |
| `keyword` |  |
| `limit` |  |
| `metadata` |  |
| `responseemail` |  |
| `schedule` |  |
| `sender` |  |
| `skip` |  |
| `status` |  |
| `tag` |  |
| `to` |  |
| `ttl` |  |
| `unread` |  |
| `validity` |  |

Operations: Create, Load, Remove.

API path: `/message/flash`

#### OneTimePassword

| Field | Description |
| --- | --- |
| `destination` |  |
| `length` |  |
| `metadata` |  |
| `passcode` |  |
| `sender` |  |
| `template` |  |
| `validity` |  |

Operations: Create, Load.

API path: `/otp/send`

#### Schedule

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Swagger

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Util

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/utils/errors/{errorcode}`



## Entities


### Batch

Create an instance: `let batch = Sdk_client.batch client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. |

#### Example: Load

```ocaml
let batch = (Sdk_client.batch client Noval).e_load (jo [("id", (Str "batch_id"))]) Noval
```


### BatchMessage

Create an instance: `let batch_message = Sdk_client.batch_message client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. |
| `e_remove reqmatch ctrl` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `string` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `value list` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `tag` | `string` |  |
| `ttl` | `float` |  |
| `validity` | `float` |  |

#### Example: Create

```ocaml
let batch_message = (Sdk_client.batch_message client Noval).e_create (jo [
    ("content", (Str "example_content"));  (* string *)
    ("destination", (empty_list ()));  (* value list *)
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
```


### Credit

Create an instance: `let credit = Sdk_client.credit client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. |

#### Example: Load

```ocaml
let credit = (Sdk_client.credit client Noval).e_load (Noval) Noval
```


### Flash

Create an instance: `let flash = Sdk_client.flash client Noval`


### Message

Create an instance: `let message = Sdk_client.message client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. |
| `e_remove reqmatch ctrl` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `string` |  |
| `credit` | `float` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `string` |  |
| `from` | `string` |  |
| `keyword` | `string` |  |
| `limit` | `float` |  |
| `metadata` | `value map` |  |
| `responseemail` | `value list` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `skip` | `float` |  |
| `status` | `string` |  |
| `tag` | `string` |  |
| `to` | `string` |  |
| `ttl` | `float` |  |
| `unread` | `bool` |  |
| `validity` | `float` |  |

#### Example: Load

```ocaml
let message = (Sdk_client.message client Noval).e_load (jo [("id", (Str "message_id"))]) Noval
```

#### Example: Create

```ocaml
let message = (Sdk_client.message client Noval).e_create (jo [
    ("content", (Str "example_content"));  (* string *)
    ("destination", (Str "example_destination"));  (* string *)
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
```


### OneTimePassword

Create an instance: `let one_time_password = Sdk_client.one_time_password client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `string` |  |
| `length` | `value map` |  |
| `metadata` | `value map` |  |
| `passcode` | `string` |  |
| `sender` | `string` |  |
| `template` | `string` |  |
| `validity` | `float` |  |

#### Example: Load

```ocaml
let one_time_password = (Sdk_client.one_time_password client Noval).e_load (jo [("messageid", (Str "messageid"))]) Noval
```

#### Example: Create

```ocaml
let one_time_password = (Sdk_client.one_time_password client Noval).e_create (jo [
]) Noval
```


### Schedule

Create an instance: `let schedule = Sdk_client.schedule client Noval`


### Swagger

Create an instance: `let swagger = Sdk_client.swagger client Noval`


### Util

Create an instance: `let util = Sdk_client.util client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. |

#### Example: Load

```ocaml
let util = (Sdk_client.util client Noval).e_load (jo [("errorcode", (Str "errorcode"))]) Noval
```


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

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as `value`

The OCaml SDK uses a single dynamic `value` type throughout rather than a
typed record per entity. `value` is the vendored voxgig struct port (a
JSON-shaped variant: `Str`, `Num`, `Bool`, `List`, `Map`, `Null`,
`Noval`). This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with the `jo` / `ja` helpers and read fields back with
`getp`; use `to_map` to safely coerce a value to a map.

### Module structure

```
ocaml/
├── sdk_client.ml               -- Main SDK client (constructors + accessors)
├── sdk_config.ml               -- Embedded API config + feature factory
├── sdk_error.ml                -- Branded error re-exports
├── sdk_entity_*.ml             -- Per-entity implementations (one each)
├── sdk_types.ml                -- Core pipeline types
├── sdk_helpers.ml              -- jo / ja / getp and friends
├── sdk_runtime.ml              -- Operation pipeline runner
├── sdk_features.ml             -- Built-in features (base, test, log)
├── utility/                    -- Vendored voxgig struct port
└── test/                       -- Test suites
```

The public surface lives in `Sdk_client` (the constructors and per-entity
accessors); `Sdk_helpers` carries the `jo` / `ja` / `getp` value
helpers. Open the runtime modules directly only when needed.

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
