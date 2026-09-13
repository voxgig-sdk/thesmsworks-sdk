# Thesmsworks Haskell SDK



The Haskell SDK for the Thesmsworks API — an entity-oriented client following idiomatic Haskell conventions (pure functions, explicit `IO`, and the dependency-free vendored `Value` struct model).

The SDK exposes the API as capitalised, semantic **Entities** — for example `batch sdk VNoval` — each
carrying a small, uniform set of operations (`eLoad`, `eCreate`, `eRemove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Hackage. Install it from the GitHub
release tag (`haskell/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) or
from a source checkout. The runtime has no third-party dependencies (only the
GHC boot libraries: `base`, `containers`, `array`, `time`), so the
bundled Makefile drives stock GHC with no cabal solve:

```bash
cd haskell && make test
```

A `.cabal` file is also generated for use with `cabal`/`stack`:

```bash
cd haskell && cabal build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```haskell
import System.Environment (lookupEnv)
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..), emptyMap)
import SdkHelpers (jo)

main :: IO ()
main = do
  mkey <- lookupEnv "THESMSWORKS_APIKEY"
  opts <- jo [("apikey", maybe VNoval VStr mkey)]
  sdk <- Sdk.newSdk opts
```

Entity operations raise on error (via `Control.Exception.throwIO`) and
return the bare result `Value`. Wrap a call in `Control.Exception.try`
to recover from failures.

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`eLoad` resolves to the ENTITY and raises on error; `eDataGet` gives the
record.

```haskell
  one_time_passwordEnt <- Sdk.one_time_password sdk VNoval
  m <- jo [("messageid", VStr "example_messageid")]
  ctrl2 <- emptyMap
  one_time_password <- Sdk.eLoad one_time_passwordEnt m ctrl2
  print =<< Sdk.eDataGet one_time_password
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

For endpoints not covered by entity accessors, use `direct` — it never
raises and returns a result `Value` you branch on via its `ok` field:

```haskell
import qualified SdkClient as Sdk
import qualified SdkFeatures as F
import VoxgigStruct (Value (..))
import SdkHelpers (jo, getp)

main :: IO ()
main = do
  sdk <- Sdk.newSdk0
  params <- jo [("id", VStr "example")]
  args <- jo [("path", VStr "/api/resource/{id}"), ("method", VStr "GET"), ("params", params)]
  result <- F.direct sdk args
  ok <- getp result "ok"
  case ok of
    VBool True -> do
      status <- getp result "status"   -- e.g. VNum 200
      body <- getp result "data"       -- the response body
      print (status, body)
    _ -> do
      -- A non-2xx response carries status + data (the error body); a
      -- transport-level failure carries err instead.
      status <- getp result "status"
      err <- getp result "err"
      print (status, err)
```

### Prepare a request without sending it

```haskell
import qualified SdkClient as Sdk
import qualified SdkFeatures as F
import VoxgigStruct (Value (..))
import SdkHelpers (jo, getp)

main :: IO ()
main = do
  sdk <- Sdk.newSdk0
  params <- jo [("id", VStr "example")]
  args <- jo [("path", VStr "/api/resource/{id}"), ("method", VStr "DELETE"), ("params", params)]
  -- prepare returns the fetch definition and raises on error.
  fetchdef <- F.prepare sdk args
  url <- getp fetchdef "url"
  method <- getp fetchdef "method"
  print (url, method)
```

### Use test mode

Create a mock client for unit testing — no server required:

```haskell
import qualified SdkClient as Sdk
import qualified SdkFeatures as F
import VoxgigStruct (Value (..), emptyMap)
import SdkHelpers (jo)

main :: IO ()
main = do
  sdk <- Sdk.testSdk0
  ent <- Sdk.batch sdk VNoval
  arg <- jo [("id", VStr "test01")]
  ctrl <- emptyMap
  -- Entity ops return the bare record and raise on error.
  batch <- Sdk.eLoad ent arg ctrl
  print batch
```

### Use a custom fetch function

Replace the HTTP transport with your own `VFunc` under `system.fetch`:

```haskell
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..))
import SdkHelpers (jo, jsonThunk)

customClient :: IO Sdk.Client
customClient = do
  let mockFetch = VFunc (\_ _ _ _ -> do
        body <- jo [("id", VStr "mock01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk body)])
  sys <- jo [("fetch", mockFetch)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  Sdk.newSdk opts
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run the suite (stock GHC, no third-party dependencies):

```bash
cd haskell && make test
```


## Reference

### Client constructors

```haskell
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..))
import SdkHelpers (jo)

makeClient :: IO Sdk.Client
makeClient = do
  opts <- jo [("base", VStr "https://api.example.com")]
  Sdk.newSdk opts
```

`newSdk :: Value -> IO Client` constructs a client from an options map;
`newSdk0 :: IO Client` is the no-argument convenience form.

| Option (map key) | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `headers` | `Value` | Custom headers for all requests. |
| `feature` | `Value` | Feature activation flags. |
| `system` | `Value` | System overrides (e.g. custom `fetch` function). |

### Test client

```haskell
client <- Sdk.testSdk testopts sdkopts
```

`testSdk :: Value -> Value -> IO Client` constructs a test-mode client with
mock transport (`testSdk0 :: IO Client` for the no-argument form). Pass
`VNoval` for defaults.

### Client functions

| Function | Signature | Description |
| --- | --- | --- |
| `newSdk` | `Value -> IO Client` | Construct a live client from options. |
| `newSdk0` | `IO Client` | Construct a live client with defaults. |
| `testSdk` | `Value -> Value -> IO Client` | Construct a test-mode client. |
| `prepare` | `Client -> Value -> IO Value` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `Client -> Value -> IO Value` | Build and send an HTTP request. Returns a result `Value` (branch on `ok`). |
| `batch` | `Client -> Value -> IO Entity` | Create a Batch entity instance. |
| `batch_message` | `Client -> Value -> IO Entity` | Create a BatchMessage entity instance. |
| `credit` | `Client -> Value -> IO Entity` | Create a Credit entity instance. |
| `flash` | `Client -> Value -> IO Entity` | Create a Flash entity instance. |
| `message` | `Client -> Value -> IO Entity` | Create a Message entity instance. |
| `one_time_password` | `Client -> Value -> IO Entity` | Create an OneTimePassword entity instance. |
| `schedule` | `Client -> Value -> IO Entity` | Create a Schedule entity instance. |
| `swagger` | `Client -> Value -> IO Entity` | Create a Swagger entity instance. |
| `util` | `Client -> Value -> IO Entity` | Create an Util entity instance. |

### Entity interface

All entities share the same record interface (fields of the `Entity` type).

| Field | Signature | Description |
| --- | --- | --- |
| `eLoad` | `Value -> Value -> IO Entity` | Load a single entity by match criteria. Resolves to the entity. Raises on error. |
| `eCreate` | `Value -> Value -> IO Entity` | Create a new entity. Resolves to the entity. Raises on error. |
| `eRemove` | `Value -> Value -> IO Entity` | Remove an entity. Resolves to the entity, marked deleted. Raises on error. |
| `eDataGet` | `IO Value` | Get entity data. |
| `eDataSet` | `Value -> IO ()` | Set entity data. |
| `eStream` | `String -> Value -> Value -> IO [Value]` | Run an op as a lazy stream of items. |
| `eMake` | `IO Entity` | Create a new instance with the same options. |
| `eName` | `String` | The entity name. |

### Result shape

Entity operations resolve to the ENTITY, not the raw record — `eList` to
one entity per record — and raise on error. The record is reached through
`eDataGet`, which returns the entity's data container. `eRemove` resolves to
the entity marked deleted (`eDeleted`); it keeps the data it held. Wrap calls
in `Control.Exception.try` to handle failures.

The `direct` escape hatch never raises — it returns a result `Value`
you branch on via its `ok` field (read with `getp result "ok"`):

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Bool` | `True` if the HTTP status is 2xx. |
| `status` | `Int` | HTTP status code. |
| `headers` | `Value` | Response headers. |
| `data` | `Value` | Parsed JSON response body. |

On error, `ok` is `False` and `err` carries the error value.

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
| `ai` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | Message to send to the recipient. |
| `credits` | The number of credits used on the message. |
| `deliveryreporturl` | The url to which we should POST delivery reports to for this message. |
| `destination` | Telephone number of the recipient |
| `from` | The date-time from which you would like matching messages |
| `id` |  |
| `keyword` | The keyword used in the inbound message |
| `limit` | The maximum number of messages that you would like returned in this call. |
| `metadata` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | Date at which to send the message. |
| `sender` | The sender of the message. |
| `skip` | The number of results you would like to ignore before returning messages. |
| `status` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | The date-time to which you would like matching messages |
| `ttl` | The optional number of minutes before the delivery report is deleted. |
| `unread` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

Operations: Create, Load, Remove.

API path: `/message/flash`

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

Create an instance: `batch <- Sdk.batch sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eLoad ent match ctrl` | Load a single entity by match criteria. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |

#### Example: Load

```haskell
  ent <- Sdk.batch sdk VNoval
  match <- jo [("id", VStr "batch_id")]
  ctrl <- emptyMap
  batch <- Sdk.eLoad ent match ctrl
  -- The op resolves to the ENTITY; the record is inside it.
  batchData <- Sdk.eDataGet batch
```


### BatchMessage

Create an instance: `batch_message <- Sdk.batch_message sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eCreate ent data ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `eRemove ent match ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `Bool` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Message to send to the recipient |
| `deliveryreporturl` | `String` | The url to which we should POST delivery reports to for this message. |
| `destinations` | `[Value]` | Telephone numbers of each of the recipients |
| `schedule` | `String` | Date-time at which to send the batch. |
| `sender` | `String` | The sender of the message. |
| `tag` | `String` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `Double` | The number of minutes before the delivery report is deleted. |
| `validity` | `Double` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Create

```haskell
  ent <- Sdk.batch_message sdk VNoval
  d <- jo
    [ ("content", VStr "example_content")   -- String
    , ("destinations", VNoval)   -- [Value]
    , ("sender", VStr "example_sender")   -- String
    ]
  ctrl <- emptyMap
  batch_message <- Sdk.eCreate ent d ctrl
  batch_messageData <- Sdk.eDataGet batch_message
```


### Credit

Create an instance: `credit <- Sdk.credit sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eLoad ent match ctrl` | Load a single entity by match criteria. Resolves to the entity. |

#### Example: Load

```haskell
  ent <- Sdk.credit sdk VNoval
  match <- jo []
  ctrl <- emptyMap
  credit <- Sdk.eLoad ent match ctrl
  -- The op resolves to the ENTITY; the record is inside it.
  creditData <- Sdk.eDataGet credit
```


### Flash

Create an instance: `flash <- Sdk.flash sdk VNoval`


### Message

Create an instance: `message <- Sdk.message sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eCreate ent data ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `eLoad ent match ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `eRemove ent match ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `Bool` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Message to send to the recipient. |
| `credits` | `Double` | The number of credits used on the message. |
| `deliveryreporturl` | `String` | The url to which we should POST delivery reports to for this message. |
| `destination` | `String` | Telephone number of the recipient |
| `from` | `String` | The date-time from which you would like matching messages |
| `id` | `String` |  |
| `keyword` | `String` | The keyword used in the inbound message |
| `limit` | `Double` | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Value` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `[Value]` | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `String` | Date at which to send the message. |
| `sender` | `String` | The sender of the message. |
| `skip` | `Double` | The number of results you would like to ignore before returning messages. |
| `status` | `String` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `String` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `String` | The date-time to which you would like matching messages |
| `ttl` | `Double` | The optional number of minutes before the delivery report is deleted. |
| `unread` | `Bool` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `Double` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Load

```haskell
  ent <- Sdk.message sdk VNoval
  match <- jo [("id", VStr "message_id")]
  ctrl <- emptyMap
  message <- Sdk.eLoad ent match ctrl
  -- The op resolves to the ENTITY; the record is inside it.
  messageData <- Sdk.eDataGet message
```

#### Example: Create

```haskell
  ent <- Sdk.message sdk VNoval
  d <- jo
    [ ("content", VStr "example_content")   -- String
    , ("destination", VStr "example_destination")   -- String
    , ("sender", VStr "example_sender")   -- String
    ]
  ctrl <- emptyMap
  message <- Sdk.eCreate ent d ctrl
  messageData <- Sdk.eDataGet message
```


### OneTimePassword

Create an instance: `one_time_password <- Sdk.one_time_password sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eCreate ent data ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `eLoad ent match ctrl` | Load a single entity by match criteria. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `String` | The phone number of the recipient. |
| `length` | `Value` | The length of the generated passcode. |
| `metadata` | `Value` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String` | A passcode you supply for use in the message template. |
| `sender` | `String` | The sender of the message. |
| `template` | `String` | A template to use as the content for the message. |
| `validity` | `Double` | The length of time in seconds for which the generated passcode should be valid. |

#### Example: Load

```haskell
  ent <- Sdk.one_time_password sdk VNoval
  match <- jo [("messageid", VStr "messageid")]
  ctrl <- emptyMap
  one_time_password <- Sdk.eLoad ent match ctrl
  -- The op resolves to the ENTITY; the record is inside it.
  one_time_passwordData <- Sdk.eDataGet one_time_password
```

#### Example: Create

```haskell
  ent <- Sdk.one_time_password sdk VNoval
  d <- jo
    []
  ctrl <- emptyMap
  one_time_password <- Sdk.eCreate ent d ctrl
  one_time_passwordData <- Sdk.eDataGet one_time_password
```


### Schedule

Create an instance: `schedule <- Sdk.schedule sdk VNoval`


### Swagger

Create an instance: `swagger <- Sdk.swagger sdk VNoval`


### Util

Create an instance: `util <- Sdk.util sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eLoad ent match ctrl` | Load a single entity by match criteria. Resolves to the entity. |

#### Example: Load

```haskell
  ent <- Sdk.util sdk VNoval
  match <- jo [("errorcode", VStr "errorcode")]
  ctrl <- emptyMap
  util <- Sdk.eLoad ent match ctrl
  -- The op resolves to the ENTITY; the record is inside it.
  utilData <- Sdk.eDataGet util
```

## Features

This SDK ships 1 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`test`](#test) | In-memory mock transport for testing without a live server |

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.


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

### Data as struct Values

The Haskell SDK models every API record as the dynamic `Value` type (from
the vendored `VoxgigStruct` module) rather than bespoke Haskell records.
This mirrors the dynamic nature of the API and keeps the SDK flexible — no
new datatypes or code generation are needed when the API schema changes.

Build request maps with `jo [(key, value)]` and read fields back with
`getp value "field"`; scalars are the `VStr` / `VNum` / `VBool`
constructors, and `VNoval` stands for an absent property.

### Module structure

```
haskell/
├── src/
│   ├── VoxgigStruct.hs   -- vendored dependency-free struct library (Value)
│   ├── Vregex.hs         -- vendored regex support
│   ├── SdkTypes.hs       -- core types (Client, Entity, Feature)
│   ├── SdkHelpers.hs     -- helper functions (jo, getp, ...)
│   ├── SdkRuntime.hs     -- the generic operation pipeline
│   ├── SdkFeatures.hs    -- built-in features + makeEntity
│   ├── SdkConfig.hs      -- generated API configuration + feature factory
│   └── SdkClient.hs      -- generated public client (newSdk, entity accessors)
├── test/                 -- test suites
├── Makefile              -- stock-GHC build/test (no third-party deps)
└── thesmsworks-sdk.cabal      -- package manifest (for Hackage)
```

The public module (`SdkClient`) exports the SDK constructors (`newSdk`,
`testSdk`) and one accessor per entity. Import `VoxgigStruct` for the
`Value` constructors and `SdkHelpers` for `jo` / `getp`.

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
