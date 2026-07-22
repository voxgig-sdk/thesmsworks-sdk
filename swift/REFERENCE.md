# Thesmsworks Swift SDK Reference

Complete API reference for the Thesmsworks Swift SDK.


## ThesmsworksSDK

### Constructor

```swift
let client = ThesmsworksSDK(options)
```

Create a new SDK client instance. `options` is a `VMap` of `Value`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `VMap` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `VMap` | Custom headers for all requests. |
| `options["feature"]` | `VMap` | Feature configuration. |
| `options["system"]` | `VMap` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```swift
let client = ThesmsworksSDK.testSDK(nil, nil)
```


### Instance Methods

#### `Batch(entopts)`

Create a new `Batch` entity instance. Pass `nil` for no initial
options.

#### `BatchMessage(entopts)`

Create a new `BatchMessage` entity instance. Pass `nil` for no initial
options.

#### `Credit(entopts)`

Create a new `Credit` entity instance. Pass `nil` for no initial
options.

#### `Flash(entopts)`

Create a new `Flash` entity instance. Pass `nil` for no initial
options.

#### `Message(entopts)`

Create a new `Message` entity instance. Pass `nil` for no initial
options.

#### `OneTimePassword(entopts)`

Create a new `OneTimePassword` entity instance. Pass `nil` for no initial
options.

#### `Schedule(entopts)`

Create a new `Schedule` entity instance. Pass `nil` for no initial
options.

#### `Swagger(entopts)`

Create a new `Swagger` entity instance. Pass `nil` for no initial
options.

#### `Util(entopts)`

Create a new `Util` entity instance. Pass `nil` for no initial
options.

#### `optionsMap() -> VMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> VMap`

Make a direct HTTP request to any API endpoint. Returns a result `VMap`
with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch never throws — branch on `result.entries["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `VMap` | Path parameter values. |
| `fetchargs["query"]` | `VMap` | Query string parameters. |
| `fetchargs["headers"]` | `VMap` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `VMap`

#### `prepare(fetchargs) throws -> VMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## Batch

```swift
let batch = client.Batch()
```

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Batch().load(VMap([("id", .string("batch_id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Batch` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## BatchMessage

```swift
let batchMessage = client.BatchMessage()
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

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.BatchMessage().create(VMap([
    ("content", .string("example_content")),  // String
    ("destination", .list([])),  // [Value]
    ("sender", .string("example_sender"))  // String
]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.BatchMessage().remove(VMap([("batchid", .string("batchid"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchMessage` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Credit

```swift
let credit = client.Credit()
```

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Credit().load(nil, nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Credit` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Flash

```swift
let flash = client.Flash()
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Flash` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Message

```swift
let message = client.Message()
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
| `metadata` | `VMap` | No |  |
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

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Message().create(VMap([
    ("content", .string("example_content")),  // String
    ("destination", .string("example_destination")),  // String
    ("sender", .string("example_sender"))  // String
]), nil)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Message().load(VMap([("id", .string("message_id"))]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Message().remove(VMap([("id", .string("message_id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Message` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OneTimePassword

```swift
let oneTimePassword = client.OneTimePassword()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No |  |
| `length` | `VMap` | No |  |
| `metadata` | `VMap` | No |  |
| `passcode` | `String` | No |  |
| `sender` | `String` | No |  |
| `template` | `String` | No |  |
| `validity` | `Double` | No |  |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.OneTimePassword().create(VMap([
]), nil)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.OneTimePassword().load(VMap([("messageid", .string("messageid"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OneTimePassword` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Schedule

```swift
let schedule = client.Schedule()
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Schedule` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Swagger

```swift
let swagger = client.Swagger()
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Swagger` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Util

```swift
let util = client.Util()
```

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Util().load(VMap([("errorcode", .string("errorcode"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Util` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```swift
let feature = VMap()
feature.entries["test"] = .map([("active", .bool(true))])
let options = VMap()
options.entries["feature"] = .map(feature)
let client = ThesmsworksSDK(options)
```

