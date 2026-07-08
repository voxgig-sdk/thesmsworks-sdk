# Thesmsworks Golang SDK



The Golang SDK for the Thesmsworks API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.Batch(nil)` — each with the same small set of operations (`Load`, `Create`, `Remove`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/thesmsworks-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/thesmsworks-sdk/go=../thesmsworks-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/thesmsworks-sdk/go"
)

func main() {
    client := sdk.NewThesmsworksSDK(map[string]any{
        "apikey": os.Getenv("THESMSWORKS_APIKEY"),
    })

    // Load a single batch — the value is the loaded record.
    batch, err := client.Batch(nil).Load(map[string]any{"id": "example_id"}, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(batch)
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
batch, err := client.Batch(nil).Load(map[string]any{"id": "example_id"}, nil)
if err != nil {
    // handle err
    return
}
_ = batch
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

batch, err := client.Batch(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(batch) // the returned mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewThesmsworksSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
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
cd go && go test ./test/...
```


## Reference

### NewThesmsworksSDK

```go
func NewThesmsworksSDK(options map[string]any) *ThesmsworksSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *ThesmsworksSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Batch` | `(data map[string]any) ThesmsworksEntity` | Create a Batch entity instance. |
| `BatchMessage` | `(data map[string]any) ThesmsworksEntity` | Create a BatchMessage entity instance. |
| `Credit` | `(data map[string]any) ThesmsworksEntity` | Create a Credit entity instance. |
| `Flash` | `(data map[string]any) ThesmsworksEntity` | Create a Flash entity instance. |
| `Message` | `(data map[string]any) ThesmsworksEntity` | Create a Message entity instance. |
| `OneTimePassword` | `(data map[string]any) ThesmsworksEntity` | Create an OneTimePassword entity instance. |
| `Schedule` | `(data map[string]any) ThesmsworksEntity` | Create a Schedule entity instance. |
| `Swagger` | `(data map[string]any) ThesmsworksEntity` | Create a Swagger entity instance. |
| `Util` | `(data map[string]any) ThesmsworksEntity` | Create an Util entity instance. |

### Entity interface (ThesmsworksEntity)

All entities implement the `ThesmsworksEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Remove` | `(reqmatch, ctrl map[string]any) (any, error)` | Remove an entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` / `Create` / `Remove` | the entity record (`map[string]any`) |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    batch, err := client.Batch(nil).Load(map[string]any{"id": "example_id"}, nil)
    if err != nil { /* handle */ }
    // batch is the returned record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Batch

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/batch/{batchid}`

#### BatchMessage

| Field | Description |
| --- | --- |
| `"ai"` |  |
| `"content"` |  |
| `"deliveryreporturl"` |  |
| `"destination"` |  |
| `"schedule"` |  |
| `"sender"` |  |
| `"tag"` |  |
| `"ttl"` |  |
| `"validity"` |  |

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
| `"ai"` |  |
| `"content"` |  |
| `"credit"` |  |
| `"deliveryreporturl"` |  |
| `"destination"` |  |
| `"from"` |  |
| `"keyword"` |  |
| `"limit"` |  |
| `"metadata"` |  |
| `"responseemail"` |  |
| `"schedule"` |  |
| `"sender"` |  |
| `"skip"` |  |
| `"status"` |  |
| `"tag"` |  |
| `"to"` |  |
| `"ttl"` |  |
| `"unread"` |  |
| `"validity"` |  |

Operations: Create, Load, Remove.

API path: `/message/flash`

#### OneTimePassword

| Field | Description |
| --- | --- |
| `"destination"` |  |
| `"length"` |  |
| `"metadata"` |  |
| `"passcode"` |  |
| `"sender"` |  |
| `"template"` |  |
| `"validity"` |  |

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

Create an instance: `batch := client.Batch(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
batch, err := client.Batch(nil).Load(map[string]any{"id": "batch_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(batch) // the loaded record
```


### BatchMessage

Create an instance: `batchMessage := client.BatchMessage(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `string` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `[]any` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `tag` | `string` |  |
| `ttl` | `float64` |  |
| `validity` | `float64` |  |

#### Example: Create

```go
result, err := client.BatchMessage(nil).Create(map[string]any{
    "content": /* string */,
    "destination": /* []any */,
    "sender": /* string */,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Credit

Create an instance: `credit := client.Credit(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
credit, err := client.Credit(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(credit) // the loaded record
```


### Flash

Create an instance: `flash := client.Flash(nil)`


### Message

Create an instance: `message := client.Message(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` |  |
| `content` | `string` |  |
| `credit` | `float64` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `string` |  |
| `from` | `string` |  |
| `keyword` | `string` |  |
| `limit` | `float64` |  |
| `metadata` | `map[string]any` |  |
| `responseemail` | `[]any` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `skip` | `float64` |  |
| `status` | `string` |  |
| `tag` | `string` |  |
| `to` | `string` |  |
| `ttl` | `float64` |  |
| `unread` | `bool` |  |
| `validity` | `float64` |  |

#### Example: Load

```go
message, err := client.Message(nil).Load(map[string]any{"id": "message_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(message) // the loaded record
```

#### Example: Create

```go
result, err := client.Message(nil).Create(map[string]any{
    "content": /* string */,
    "destination": /* string */,
    "sender": /* string */,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### OneTimePassword

Create an instance: `oneTimePassword := client.OneTimePassword(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `string` |  |
| `length` | `map[string]any` |  |
| `metadata` | `map[string]any` |  |
| `passcode` | `string` |  |
| `sender` | `string` |  |
| `template` | `string` |  |
| `validity` | `float64` |  |

#### Example: Load

```go
oneTimePassword, err := client.OneTimePassword(nil).Load(map[string]any{"messageid": "messageid"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(oneTimePassword) // the loaded record
```

#### Example: Create

```go
result, err := client.OneTimePassword(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Schedule

Create an instance: `schedule := client.Schedule(nil)`


### Swagger

Create an instance: `swagger := client.Swagger(nil)`


### Util

Create an instance: `util := client.Util(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
util, err := client.Util(nil).Load(map[string]any{"errorcode": "errorcode"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(util) // the loaded record
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

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/thesmsworks-sdk/go/
├── thesmsworks.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/thesmsworks-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
batch := client.Batch(nil)
batch.Load(map[string]any{"id": "example_id"}, nil)

// batch.Data() now returns the batch data from the last load
// batch.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
