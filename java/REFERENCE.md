# Thesmsworks Java SDK Reference

Complete API reference for the Thesmsworks Java SDK.


## ThesmsworksSDK

### Constructor

```java
ThesmsworksSDK client = new ThesmsworksSDK(options);
```

Create a new SDK client instance. `options` is a `Map<String, Object>`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Map` | Custom headers for all requests. |
| `options["feature"]` | `Map` | Feature configuration. |
| `options["system"]` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `null`.

```java
ThesmsworksSDK client = ThesmsworksSDK.testSDK(null, null);
```


### Instance Methods

#### `batch(entopts)`

Create a new `Batch` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `batchMessage(entopts)`

Create a new `BatchMessage` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `credit(entopts)`

Create a new `Credit` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `flash(entopts)`

Create a new `Flash` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `message(entopts)`

Create a new `Message` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `oneTimePassword(entopts)`

Create a new `OneTimePassword` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `schedule(entopts)`

Create a new `Schedule` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `swagger(entopts)`

Create a new `Swagger` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `util(entopts)`

Create a new `Util` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optionsMap() -> Map`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Map`

Make a direct HTTP request to any API endpoint. Returns a result
`Map<String, Object>` with `ok`, `status`, `headers`, and `data` (or
`err` on failure). This escape hatch never raises — branch on
`result.get("ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Object` | Request body (maps are JSON-serialized). |

**Returns:** `Map<String, Object>`

#### `prepare(fetchargs) -> Map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Batch

```java
SdkEntity batch = client.batch(null);
```

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```java
Object result = client.batch(null).load(Map.of("id", "batch_id"), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Batch` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## BatchMessage

```java
SdkEntity batchMessage = client.batchMessage(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean` | No |  |
| `content` | `String` | Yes |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `List<Object>` | Yes |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `tag` | `String` | No |  |
| `ttl` | `double` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.batchMessage(null).create(Map.of(
    "content", "example_content",  // String
    "destination", List.of(),  // List<Object>
    "sender", "example_sender"  // String
), null);
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```java
Object result = client.batchMessage(null).remove(Map.of("batchid", "batchid"), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchMessage` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Credit

```java
SdkEntity credit = client.credit(null);
```

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```java
Object result = client.credit(null).load(null, null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Credit` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Flash

```java
SdkEntity flash = client.flash(null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Flash` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Message

```java
SdkEntity message = client.message(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean` | No |  |
| `content` | `String` | Yes |  |
| `credit` | `double` | No |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `String` | Yes |  |
| `from` | `String` | No |  |
| `keyword` | `String` | No |  |
| `limit` | `double` | No |  |
| `metadata` | `Map<String, Object>` | No |  |
| `responseemail` | `List<Object>` | No |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `skip` | `double` | No |  |
| `status` | `String` | No |  |
| `tag` | `String` | No |  |
| `to` | `String` | No |  |
| `ttl` | `double` | No |  |
| `unread` | `boolean` | No |  |
| `validity` | `double` | No |  |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.message(null).create(Map.of(
    "content", "example_content",  // String
    "destination", "example_destination",  // String
    "sender", "example_sender"  // String
), null);
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```java
Object result = client.message(null).load(Map.of("id", "message_id"), null);
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```java
Object result = client.message(null).remove(Map.of("id", "message_id"), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Message` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OneTimePassword

```java
SdkEntity oneTimePassword = client.oneTimePassword(null);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No |  |
| `length` | `Map<String, Object>` | No |  |
| `metadata` | `Map<String, Object>` | No |  |
| `passcode` | `String` | No |  |
| `sender` | `String` | No |  |
| `template` | `String` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.oneTimePassword(null).create(Map.of(
), null);
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```java
Object result = client.oneTimePassword(null).load(Map.of("messageid", "messageid"), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OneTimePassword` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Schedule

```java
SdkEntity schedule = client.schedule(null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Schedule` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Swagger

```java
SdkEntity swagger = client.swagger(null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Swagger` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Util

```java
SdkEntity util = client.util(null);
```

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```java
Object result = client.util(null).load(Map.of("errorcode", "errorcode"), null);
```

### Common Methods

#### `data(newdata...) -> Object`

Get or set the entity data.

#### `match(newmatch...) -> Object`

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

```java
Map<String, Object> feature = new java.util.LinkedHashMap<>();
feature.put("test", Map.of("active", true));
Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("feature", feature);
ThesmsworksSDK client = new ThesmsworksSDK(options);
```

