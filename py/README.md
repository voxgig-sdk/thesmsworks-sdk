# Thesmsworks Python SDK



The Python SDK for the Thesmsworks API — an entity-oriented client following Pythonic conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Batch()` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to PyPI. Install it from the GitHub
release tag (`py/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) or
from a source checkout:

```bash
pip install -e .
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```python
import os
from thesmsworks_sdk import ThesmsworksSDK

client = ThesmsworksSDK({
    "apikey": os.environ.get("THESMSWORKS_APIKEY"),
})
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the bare record (a `dict`) and raises on error.

```python
try:
    onetimepassword = client.OneTimePassword().load({"messageid": "example_messageid"})
    print(onetimepassword)
except Exception as err:
    print(f"load failed: {err}")
```


## Error handling

Entity operations raise on failure, so wrap them in `try` / `except`:

```python
try:
    batch = client.Batch().load({"id": "example_id"})
    print(batch)
except Exception as err:
    print(f"load failed: {err}")
```

`direct()` does **not** raise — it returns the result envelope. Branch
on `ok`; on failure `status` holds the HTTP status (for error responses)
and `err` holds a transport error, so read both defensively:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example_id"},
})

if not result["ok"]:
    print("request failed:", result.get("status"), result.get("err"))
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})

if result["ok"]:
    print(result["status"])  # 200
    print(result["data"])    # response body
else:
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read both with .get() rather than indexing a key that may be absent.
    print(result.get("status"), result.get("err"))
```

### Prepare a request without sending it

```python
# prepare() returns the fetch definition and raises on error.
fetchdef = client.prepare({
    "path": "/api/resource/{id}",
    "method": "DELETE",
    "params": {"id": "example"},
})

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```python
client = ThesmsworksSDK.test()

# Entity ops return the bare record and raise on error.
batch = client.Batch().load({"id": "test01"})
# batch contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```python
def mock_fetch(url, init):
    return {
        "status": 200,
        "statusText": "OK",
        "headers": {},
        "json": lambda: {"id": "mock01"},
    }, None

client = ThesmsworksSDK({
    "base": "http://localhost:8080",
    "system": {
        "fetch": mock_fetch,
    },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd py && pytest test/
```


## Reference

### ThesmsworksSDK

```python
from thesmsworks_sdk import ThesmsworksSDK

client = ThesmsworksSDK(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `str` | API key for authentication. |
| `base` | `str` | Base URL of the API server. |
| `prefix` | `str` | URL path prefix prepended to all requests. |
| `suffix` | `str` | URL path suffix appended to all requests. |
| `feature` | `dict` | Feature activation flags. |
| `extend` | `list` | Additional Feature instances to load. |
| `system` | `dict` | System overrides (e.g. custom `fetch` function). |

### test

```python
client = ThesmsworksSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `None`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> dict` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> dict` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> dict` | Build and send an HTTP request. Returns a result dict (branch on `ok`). |
| `Batch` | `(data) -> BatchEntity` | Create a Batch entity instance. |
| `BatchMessage` | `(data) -> BatchMessageEntity` | Create a BatchMessage entity instance. |
| `Credit` | `(data) -> CreditEntity` | Create a Credit entity instance. |
| `Flash` | `(data) -> FlashEntity` | Create a Flash entity instance. |
| `Message` | `(data) -> MessageEntity` | Create a Message entity instance. |
| `OneTimePassword` | `(data) -> OneTimePasswordEntity` | Create an OneTimePassword entity instance. |
| `Schedule` | `(data) -> ScheduleEntity` | Create a Schedule entity instance. |
| `Swagger` | `(data) -> SwaggerEntity` | Create a Swagger entity instance. |
| `Util` | `(data) -> UtilEntity` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> any` | Remove an entity. Raises on error. |
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `dict` for single-entity
ops, a `list` for `list`) and raise on error. Wrap calls in
`try`/`except` to handle failures.

The `direct()` escape hatch never raises — it returns a result `dict`
you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `True` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `dict` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `False` and `err` contains the error value.

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

Create an instance: `batch = client.Batch()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
batch = client.Batch().load({"id": "batch_id"})
```


### BatchMessage

Create an instance: `batch_message = client.BatchMessage()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `str` |  |
| `deliveryreporturl` | `str` |  |
| `destination` | `list` |  |
| `schedule` | `str` |  |
| `sender` | `str` |  |
| `tag` | `str` |  |
| `ttl` | `float` |  |
| `validity` | `float` |  |

#### Example: Create

```python
batch_message = client.BatchMessage().create({
    "content": "example_content",  # str
    "destination": [],  # list
    "sender": "example_sender",  # str
})
```


### Credit

Create an instance: `credit = client.Credit()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
credit = client.Credit().load()
```


### Flash

Create an instance: `flash = client.Flash()`


### Message

Create an instance: `message = client.Message()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `str` |  |
| `credit` | `float` |  |
| `deliveryreporturl` | `str` |  |
| `destination` | `str` |  |
| `from` | `str` |  |
| `keyword` | `str` |  |
| `limit` | `float` |  |
| `metadata` | `dict` |  |
| `responseemail` | `list` |  |
| `schedule` | `str` |  |
| `sender` | `str` |  |
| `skip` | `float` |  |
| `status` | `str` |  |
| `tag` | `str` |  |
| `to` | `str` |  |
| `ttl` | `float` |  |
| `unread` | `bool` |  |
| `validity` | `float` |  |

#### Example: Load

```python
message = client.Message().load({"id": "message_id"})
```

#### Example: Create

```python
message = client.Message().create({
    "content": "example_content",  # str
    "destination": "example_destination",  # str
    "sender": "example_sender",  # str
})
```


### OneTimePassword

Create an instance: `one_time_password = client.OneTimePassword()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `str` |  |
| `length` | `dict` |  |
| `metadata` | `dict` |  |
| `passcode` | `str` |  |
| `sender` | `str` |  |
| `template` | `str` |  |
| `validity` | `float` |  |

#### Example: Load

```python
one_time_password = client.OneTimePassword().load({"messageid": "messageid"})
```

#### Example: Create

```python
one_time_password = client.OneTimePassword().create({
})
```


### Schedule

Create an instance: `schedule = client.Schedule()`


### Swagger

Create an instance: `swagger = client.Swagger()`


### Util

Create an instance: `util = client.Util()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
util = client.Util().load({"errorcode": "errorcode"})
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

Features are the extension mechanism. A feature is a Python class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dicts

The Python SDK uses plain dicts throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a dict.

### Module structure

```
py/
├── thesmsworks_sdk.py         -- Main SDK module
├── config.py                    -- Configuration
├── features.py                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (Base, Test, Log)
├── utility/                     -- Utility functions and struct library
└── test/                        -- Test suites
```

The main module (`thesmsworks_sdk`) exports the SDK class.
Import entity or utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```python
batch = client.Batch()
batch.load({"id": "example_id"})

# batch.data_get() now returns the batch data from the last load
# batch.match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
