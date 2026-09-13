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

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `eLoad ent match ctrl :: IO Entity`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

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
| `ai` | `Bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `String` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `[Value]` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `String` | No | Date-time at which to send the batch. |
| `sender` | `String` | Yes | The sender of the message. |
| `tag` | `String` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `Double` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `Double` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.batch_message sdk VNoval
  d <- jo
    [ ("content", VStr "example_content")   -- String
    , ("destinations", VNoval)   -- [Value]
    , ("sender", VStr "example_sender")   -- String
    ]
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

#### `eRemove ent match ctrl :: IO Entity`

Remove the entity matching the given criteria. Resolves to the ENTITY, marked deleted (`eDeleted`); it keeps the data it held. Raises on error.

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

#### `eLoad ent match ctrl :: IO Entity`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

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
| `ai` | `Bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Yes | Message to send to the recipient. |
| `credits` | `Double` | No | The number of credits used on the message. |
| `deliveryreporturl` | `String` | No | The url to which we should POST delivery reports to for this message. |
| `destination` | `String` | Yes | Telephone number of the recipient |
| `from` | `String` | No | The date-time from which you would like matching messages |
| `id` | `String` | No |  |
| `keyword` | `String` | No | The keyword used in the inbound message |
| `limit` | `Double` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Value` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `[Value]` | No | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `String` | No | Date at which to send the message. |
| `sender` | `String` | Yes | The sender of the message. |
| `skip` | `Double` | No | The number of results you would like to ignore before returning messages. |
| `status` | `String` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `String` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `String` | No | The date-time to which you would like matching messages |
| `ttl` | `Double` | No | The optional number of minutes before the delivery report is deleted. |
| `unread` | `Bool` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `Double` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

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

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.message sdk VNoval
  d <- jo
    [ ("content", VStr "example_content")   -- String
    , ("destination", VStr "example_destination")   -- String
    , ("sender", VStr "example_sender")   -- String
    ]
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

#### `eLoad ent match ctrl :: IO Entity`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.message sdk VNoval
  match <- jo [("id", VStr "message_id")]
  ctrl <- emptyMap
  result <- Sdk.eLoad ent match ctrl
```

#### `eRemove ent match ctrl :: IO Entity`

Remove the entity matching the given criteria. Resolves to the ENTITY, marked deleted (`eDeleted`); it keeps the data it held. Raises on error.

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
| `destination` | `String` | No | The phone number of the recipient. |
| `length` | `Value` | No | The length of the generated passcode. |
| `metadata` | `Value` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String` | No | A passcode you supply for use in the message template. |
| `sender` | `String` | No | The sender of the message. |
| `template` | `String` | No | A template to use as the content for the message. |
| `validity` | `Double` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `eCreate ent data ctrl :: IO Entity`

Create a new entity with the given data. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

```haskell
  ent <- Sdk.one_time_password sdk VNoval
  d <- jo
    []
  ctrl <- emptyMap
  result <- Sdk.eCreate ent d ctrl   -- the ENTITY
  d2 <- Sdk.eDataGet result
```

#### `eLoad ent match ctrl :: IO Entity`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

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

#### `eLoad ent match ctrl :: IO Entity`

Load a single entity matching the given criteria. Resolves to the ENTITY (read the record with `eDataGet`) and raises on error.

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

