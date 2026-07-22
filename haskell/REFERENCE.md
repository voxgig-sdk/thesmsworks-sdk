# Thesmsworks Haskell SDK Reference

Complete API reference for the Thesmsworks Haskell SDK.


## Client

### Constructors

```haskell
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..))
import SdkHelpers (jo)

makeClient :: IO Sdk.Client
makeClient = do
  opts <- jo [("base", VStr "https://api.example.com")]
  Sdk.newSdk opts
```

Construct a live SDK client.

**Functions:**

| Function | Signature | Description |
| --- | --- | --- |
| `newSdk` | `Value -> IO Client` | Construct a client from an options map. |
| `newSdk0` | `IO Client` | Construct a client with defaults. |

**Options (map keys):**

| Key | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL for API requests. |
| `prefix` | `String` | URL prefix appended after base. |
| `suffix` | `String` | URL suffix appended after path. |
| `headers` | `Value` | Custom headers for all requests. |
| `feature` | `Value` | Feature configuration. |
| `system` | `Value` | System overrides (e.g. custom fetch). |


### Test constructors

```haskell
client <- Sdk.testSdk0
```

`testSdk :: Value -> Value -> IO Client` constructs a test client with mock
features active (`testSdk0 :: IO Client` for the no-argument form). Pass
`VNoval` for defaults.


### Entity accessors

#### `batch :: Client -> Value -> IO Entity`

Construct a `Batch` entity bound to the client. Pass `VNoval` for no initial options.

#### `batch_message :: Client -> Value -> IO Entity`

Construct a `BatchMessage` entity bound to the client. Pass `VNoval` for no initial options.

#### `credit :: Client -> Value -> IO Entity`

Construct a `Credit` entity bound to the client. Pass `VNoval` for no initial options.

#### `flash :: Client -> Value -> IO Entity`

Construct a `Flash` entity bound to the client. Pass `VNoval` for no initial options.

#### `message :: Client -> Value -> IO Entity`

Construct a `Message` entity bound to the client. Pass `VNoval` for no initial options.

#### `one_time_password :: Client -> Value -> IO Entity`

Construct a `OneTimePassword` entity bound to the client. Pass `VNoval` for no initial options.

#### `schedule :: Client -> Value -> IO Entity`

Construct a `Schedule` entity bound to the client. Pass `VNoval` for no initial options.

#### `swagger :: Client -> Value -> IO Entity`

Construct a `Swagger` entity bound to the client. Pass `VNoval` for no initial options.

#### `util :: Client -> Value -> IO Entity`

Construct a `Util` entity bound to the client. Pass `VNoval` for no initial options.

### HTTP escape hatches

#### `direct :: Client -> Value -> IO Value` (module `SdkFeatures`)

Make a direct HTTP request to any API endpoint. Returns a result `Value` with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never raises — branch on `getp result "ok"`.

**Argument (map keys):**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `String` | URL path with optional `{param}` placeholders. |
| `method` | `String` | HTTP method (default: `"GET"`). |
| `params` | `Value` | Path parameter values. |
| `query` | `Value` | Query string parameters. |
| `headers` | `Value` | Request headers (merged with defaults). |
| `body` | `Value` | Request body (maps are JSON-serialized). |

#### `prepare :: Client -> Value -> IO Value` (module `SdkFeatures`)

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Batch

```haskell
  ent <- Sdk.batch sdk VNoval
```

### Operations

#### `eLoad ent match ctrl :: IO Value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```haskell
  ent <- Sdk.batch sdk VNoval
  match <- jo [("id", VStr "batch_id")]
  ctrl <- emptyMap
  result <- Sdk.eLoad ent match ctrl
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Batch` entity with the same options.

#### `eName :: String`

The entity name.


---

## BatchMessage

```haskell
  ent <- Sdk.batch_message sdk VNoval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `Bool` | No |  |
| `content` | `String` | Yes |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `[Value]` | Yes |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `tag` | `String` | No |  |
| `ttl` | `Double` | No |  |
| `validity` | `Double` | No |  |

### Operations

#### `eCreate ent data ctrl :: IO Value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```haskell
  ent <- Sdk.batch_message sdk VNoval
  d <- jo
    [ ("content", VStr "example_content")   -- String
    , ("destination", VNoval)   -- [Value]
    , ("sender", VStr "example_sender")   -- String
    ]
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl
```

#### `eRemove ent match ctrl :: IO Value`

Remove the entity matching the given criteria. Raises on error.

```haskell
  ent <- Sdk.batch_message sdk VNoval
  match <- jo [("batchid", VStr "batchid")]
  ctrl <- emptyMap
  result <- Sdk.eRemove ent match ctrl
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `BatchMessage` entity with the same options.

#### `eName :: String`

The entity name.


---

## Credit

```haskell
  ent <- Sdk.credit sdk VNoval
```

### Operations

#### `eLoad ent match ctrl :: IO Value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```haskell
  ent <- Sdk.credit sdk VNoval
  match <- jo []
  ctrl <- emptyMap
  result <- Sdk.eLoad ent match ctrl
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Credit` entity with the same options.

#### `eName :: String`

The entity name.


---

## Flash

```haskell
  ent <- Sdk.flash sdk VNoval
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Flash` entity with the same options.

#### `eName :: String`

The entity name.


---

## Message

```haskell
  ent <- Sdk.message sdk VNoval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `Bool` | No |  |
| `content` | `String` | Yes |  |
| `credit` | `Double` | No |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `String` | Yes |  |
| `from` | `String` | No |  |
| `keyword` | `String` | No |  |
| `limit` | `Double` | No |  |
| `metadata` | `Value` | No |  |
| `responseemail` | `[Value]` | No |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `skip` | `Double` | No |  |
| `status` | `String` | No |  |
| `tag` | `String` | No |  |
| `to` | `String` | No |  |
| `ttl` | `Double` | No |  |
| `unread` | `Bool` | No |  |
| `validity` | `Double` | No |  |

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

#### `eCreate ent data ctrl :: IO Value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```haskell
  ent <- Sdk.message sdk VNoval
  d <- jo
    [ ("content", VStr "example_content")   -- String
    , ("destination", VStr "example_destination")   -- String
    , ("sender", VStr "example_sender")   -- String
    ]
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl
```

#### `eLoad ent match ctrl :: IO Value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```haskell
  ent <- Sdk.message sdk VNoval
  match <- jo [("id", VStr "message_id")]
  ctrl <- emptyMap
  result <- Sdk.eLoad ent match ctrl
```

#### `eRemove ent match ctrl :: IO Value`

Remove the entity matching the given criteria. Raises on error.

```haskell
  ent <- Sdk.message sdk VNoval
  match <- jo [("id", VStr "message_id")]
  ctrl <- emptyMap
  result <- Sdk.eRemove ent match ctrl
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Message` entity with the same options.

#### `eName :: String`

The entity name.


---

## OneTimePassword

```haskell
  ent <- Sdk.one_time_password sdk VNoval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No |  |
| `length` | `Value` | No |  |
| `metadata` | `Value` | No |  |
| `passcode` | `String` | No |  |
| `sender` | `String` | No |  |
| `template` | `String` | No |  |
| `validity` | `Double` | No |  |

### Operations

#### `eCreate ent data ctrl :: IO Value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```haskell
  ent <- Sdk.one_time_password sdk VNoval
  d <- jo
    []
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl
```

#### `eLoad ent match ctrl :: IO Value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```haskell
  ent <- Sdk.one_time_password sdk VNoval
  match <- jo [("messageid", VStr "messageid")]
  ctrl <- emptyMap
  result <- Sdk.eLoad ent match ctrl
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `OneTimePassword` entity with the same options.

#### `eName :: String`

The entity name.


---

## Schedule

```haskell
  ent <- Sdk.schedule sdk VNoval
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Schedule` entity with the same options.

#### `eName :: String`

The entity name.


---

## Swagger

```haskell
  ent <- Sdk.swagger sdk VNoval
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Swagger` entity with the same options.

#### `eName :: String`

The entity name.


---

## Util

```haskell
  ent <- Sdk.util sdk VNoval
```

### Operations

#### `eLoad ent match ctrl :: IO Value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```haskell
  ent <- Sdk.util sdk VNoval
  match <- jo [("errorcode", VStr "errorcode")]
  ctrl <- emptyMap
  result <- Sdk.eLoad ent match ctrl
```

### Common Fields

#### `eDataGet :: IO Value`

Get the entity data.

#### `eDataSet :: Value -> IO ()`

Set the entity data.

#### `eStream :: String -> Value -> Value -> IO [Value]`

Run an operation as a lazy stream of result items.

#### `eMake :: IO Entity`

Create a new `Util` entity with the same options.

#### `eName :: String`

The entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```haskell
  active <- jo [("active", VBool True)]
  featureCfg <- jo
    [ ("test", active)
    ]
  opts <- jo [("feature", featureCfg)]
  client <- Sdk.newSdk opts
```

