# Thesmsworks C SDK



The C SDK for the Thesmsworks API — an entity-oriented client following idiomatic C conventions (explicit structs, function-pointer vtables, and a trailing `PNError**` out-param for errors).

The SDK exposes the API as capitalised, semantic **Entities** — for example `thesmsworks_batch(client, NULL)` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
C has no central package registry — a release is the git tag
(`c/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)). Build from a
source checkout with the bundled `Makefile`; the voxgig struct library is
vendored under `utility/struct`, so there are no external dependencies to
fetch:

```bash
cd c && make          # builds libsdk.a
cd c && make test     # builds + runs the test binaries
```

Link your program against `libsdk.a` and include `core/api.h`:

```bash
cc -I c/core -I c/utility/struct \
   myapp.c c/libsdk.a -lm -o myapp
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```c
#include "core/api.h"

ThesmsworksSDK* client = thesmsworks_sdk_new(cmap(1,
    "apikey", v_str(getenv("THESMSWORKS_APIKEY"))));
PNError* err = NULL;
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the bare record and sets `*err` on failure.

```c
Entity* one_time_password = thesmsworks_one_time_password(client, NULL);
voxgig_value* one_time_password_rec = one_time_password->vt->load(one_time_password, cmap(1, "messageid", v_str("example_messageid")), NULL, &err);
if (err) {
    fprintf(stderr, "load failed: %s\n", err->msg);
} else {
    printf("%s\n", voxgig_to_json(one_time_password_rec));
}
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

For endpoints not covered by entity operations:

```c
PNError* err = NULL;
voxgig_value* result = sdk_direct(client, cmap(3,
    "path", v_str("/api/resource/{id}"),
    "method", v_str("GET"),
    "params", cmap(1, "id", v_str("example"))), &err);

if (voxgig_as_bool(getp(result, "ok"))) {
    printf("%lld\n", (long long)to_int(getp(result, "status")));  // 200
    printf("%s\n", voxgig_to_json(getp(result, "data")));         // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    printf("%s\n", voxgig_to_json(getp(result, "err")));
}
```

`sdk_direct()` never sets `*err` for a non-2xx response — it always returns
a result map you branch on via `getp(result, "ok")`.

### Prepare a request without sending it

```c
PNError* err = NULL;
voxgig_value* fetchdef = sdk_prepare(client, cmap(3,
    "path", v_str("/api/resource/{id}"),
    "method", v_str("DELETE"),
    "params", cmap(1, "id", v_str("example"))), &err);

printf("%s\n", get_str(fetchdef, "url"));
printf("%s\n", get_str(fetchdef, "method"));
printf("%s\n", voxgig_to_json(getp(fetchdef, "headers")));
```

### Use test mode

Create a mock client for unit testing — no server required:

```c
ThesmsworksSDK* client = test_sdk(NULL, NULL);
PNError* err = NULL;

// Entity ops return the bare record and set *err on failure.
Entity* batch = thesmsworks_batch(client, NULL);
voxgig_value* batch_rec = batch->vt->load(batch, cmap(1, "id", v_str("test01")), NULL, &err);
// batch_rec contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function (the same shape the test
transport uses):

```c
static voxgig_value* mock_fetch(void* ud, voxgig_value* args) {
    (void)ud; (void)args;
    return cmap(4,
        "status", v_num(200),
        "statusText", v_str("OK"),
        "headers", v_map(),
        "json", json_thunk(cmap(1, "id", v_str("mock01"))));
}

ThesmsworksSDK* client = thesmsworks_sdk_new(cmap(2,
    "base", v_str("http://localhost:8080"),
    "system", cmap(1, "fetch", vfn(mock_fetch, NULL))));
```

### Point at a different server

Override the base URL to reach a local or staging server:

```c
ThesmsworksSDK* client = thesmsworks_sdk_new(cmap(1,
    "base", v_str("http://localhost:8080")));
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd c && make test
```


## Reference

### ThesmsworksSDK

```c
#include "core/api.h"

ThesmsworksSDK* client = thesmsworks_sdk_new(options);
```

Creates a new SDK client. `options` is a `voxgig_value*` map (`NULL` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom `fetch`). |

### test_sdk

```c
ThesmsworksSDK* client = test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`NULL`.

### ThesmsworksSDK functions

| Function | Signature | Description |
| --- | --- | --- |
| `sdk_prepare` | `(ThesmsworksSDK*, fetchargs, PNError**) -> voxgig_value*` | Build an HTTP request definition without sending. |
| `sdk_direct` | `(ThesmsworksSDK*, fetchargs, PNError**) -> voxgig_value*` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `thesmsworks_batch` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create a Batch entity instance. |
| `thesmsworks_batch_message` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create a BatchMessage entity instance. |
| `thesmsworks_credit` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create a Credit entity instance. |
| `thesmsworks_flash` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create a Flash entity instance. |
| `thesmsworks_message` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create a Message entity instance. |
| `thesmsworks_one_time_password` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create an OneTimePassword entity instance. |
| `thesmsworks_schedule` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create a Schedule entity instance. |
| `thesmsworks_swagger` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create a Swagger entity instance. |
| `thesmsworks_util` | `(ThesmsworksSDK*, entopts) -> Entity*` | Create an Util entity instance. |

### Entity interface (vtable)

All entities share the same `EntityVT` vtable, reached via `e->vt->...`.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(Entity*, reqmatch, ctrl, PNError**) -> voxgig_value*` | Load a single entity by match criteria. |
| `create` | `(Entity*, reqdata, ctrl, PNError**) -> voxgig_value*` | Create a new entity. |
| `remove` | `(Entity*, reqmatch, ctrl, PNError**) -> voxgig_value*` | Remove an entity. |
| `data` | `(Entity*, args) -> voxgig_value*` | Get entity data (pass a map to set). |
| `matchv` | `(Entity*, args) -> voxgig_value*` | Get entity match criteria (pass a map to set). |
| `make` | `(Entity*) -> Entity*` | Create a new instance with the same options. |
| `get_name` | `(Entity*) -> const char*` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `voxgig_value` map for
single-entity ops, a List for `list`) and set `*err` to a `PNError*` on
failure. Always initialise `PNError* err = NULL;` and check it after the
call.

The `sdk_direct()` escape hatch never sets `*err` for a non-2xx response —
it returns a result map you branch on via `getp(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error value.

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

Create an instance: `Entity* batch = thesmsworks_batch(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |

#### Example: Load

```c
Entity* batch = thesmsworks_batch(client, NULL);
voxgig_value* batch_rec = batch->vt->load(batch, cmap(1, "id", v_str("batch_id")), NULL, &err);
```


### BatchMessage

Create an instance: `Entity* batch_message = thesmsworks_batch_message(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `char*` |  |
| `deliveryreporturl` | `char*` |  |
| `destination` | `voxgig_value* (list)` |  |
| `schedule` | `char*` |  |
| `sender` | `char*` |  |
| `tag` | `char*` |  |
| `ttl` | `double` |  |
| `validity` | `double` |  |

#### Example: Create

```c
Entity* batch_message = thesmsworks_batch_message(client, NULL);
voxgig_value* batch_message_rec = batch_message->vt->create(batch_message, cmap(3,
    "content", v_str("example_content"),  // char*
    "destination", v_list(),  // voxgig_value* (list)
    "sender", v_str("example_sender"))  // char*
, NULL, &err);
```


### Credit

Create an instance: `Entity* credit = thesmsworks_credit(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |

#### Example: Load

```c
Entity* credit = thesmsworks_credit(client, NULL);
voxgig_value* credit_rec = credit->vt->load(credit, NULL, NULL, &err);
```


### Flash

Create an instance: `Entity* flash = thesmsworks_flash(client, NULL);`


### Message

Create an instance: `Entity* message = thesmsworks_message(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `char*` |  |
| `credit` | `double` |  |
| `deliveryreporturl` | `char*` |  |
| `destination` | `char*` |  |
| `from` | `char*` |  |
| `keyword` | `char*` |  |
| `limit` | `double` |  |
| `metadata` | `voxgig_value* (map)` |  |
| `responseemail` | `voxgig_value* (list)` |  |
| `schedule` | `char*` |  |
| `sender` | `char*` |  |
| `skip` | `double` |  |
| `status` | `char*` |  |
| `tag` | `char*` |  |
| `to` | `char*` |  |
| `ttl` | `double` |  |
| `unread` | `bool` |  |
| `validity` | `double` |  |

#### Example: Load

```c
Entity* message = thesmsworks_message(client, NULL);
voxgig_value* message_rec = message->vt->load(message, cmap(1, "id", v_str("message_id")), NULL, &err);
```

#### Example: Create

```c
Entity* message = thesmsworks_message(client, NULL);
voxgig_value* message_rec = message->vt->create(message, cmap(3,
    "content", v_str("example_content"),  // char*
    "destination", v_str("example_destination"),  // char*
    "sender", v_str("example_sender"))  // char*
, NULL, &err);
```


### OneTimePassword

Create an instance: `Entity* one_time_password = thesmsworks_one_time_password(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `char*` |  |
| `length` | `voxgig_value* (map)` |  |
| `metadata` | `voxgig_value* (map)` |  |
| `passcode` | `char*` |  |
| `sender` | `char*` |  |
| `template` | `char*` |  |
| `validity` | `double` |  |

#### Example: Load

```c
Entity* one_time_password = thesmsworks_one_time_password(client, NULL);
voxgig_value* one_time_password_rec = one_time_password->vt->load(one_time_password, cmap(1, "messageid", v_str("messageid")), NULL, &err);
```

#### Example: Create

```c
Entity* one_time_password = thesmsworks_one_time_password(client, NULL);
voxgig_value* one_time_password_rec = one_time_password->vt->create(one_time_password, NULL, NULL, &err);
```


### Schedule

Create an instance: `Entity* schedule = thesmsworks_schedule(client, NULL);`


### Swagger

Create an instance: `Entity* swagger = thesmsworks_swagger(client, NULL);`


### Util

Create an instance: `Entity* util = thesmsworks_util(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |

#### Example: Load

```c
Entity* util = thesmsworks_util(client, NULL);
voxgig_value* util_rec = util->vt->load(util, cmap(1, "errorcode", v_str("errorcode")), NULL, &err);
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

### Data as `voxgig_value*`

The C SDK uses a single dynamic `voxgig_value*` type throughout rather than
a typed struct per entity. `voxgig_value` is the vendored voxgig struct
port (a JSON-shaped tagged union: string, number, bool, list, map, null,
undef). This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with the `cmap` / `clist` / `v_str` / `v_num` /
`v_bool` helper builders, and read fields back with `getp` (or the typed
`get_str` / `get_bool` / `to_int`); use `to_map` to safely coerce a
value to a map.

Memory follows a retain-heavy, never-free discipline — pipeline values are
never released. This is safe (no use-after-free) and leaks are acceptable
for the short-lived SDK and test binaries.

### Error handling

Fallible functions return a `voxgig_value*` (or a struct pointer) and take a
trailing `PNError** err` out-param. On success `*err` is left `NULL`; on
failure `*err` points to a heap `PNError` carrying `code` and `msg`.
Always initialise `PNError* err = NULL;` and branch on it after each call.

### Project structure

```
c/
├── core/          -- Pipeline types, config, client (client.c), api.h + sdk.h
├── entity/        -- Per-entity implementations (one .c each)
├── feature/       -- Built-in features (base, test, log, ...)
├── utility/       -- Utilities + the vendored voxgig struct port (utility/struct)
├── tests/         -- Test binaries (each a standalone main())
└── Makefile       -- Builds libsdk.a and runs every tests/*.c
```

The public entry header is `core/api.h` — it includes `core/sdk.h` (the
umbrella runtime header) and declares each entity's constructor and SDK
accessor. Include it and link against `libsdk.a`.

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
