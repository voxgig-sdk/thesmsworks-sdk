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
| `ai` | `Boolean` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `String` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `List<Object>` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `String` | No | Date-time at which to send the batch. |
| `sender` | `String` | Yes | The sender of the message. |
| `tag` | `String` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `Double` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `Double` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```java
Object result = client.batchMessage(null).create(Map.of(
    "content", "example_content",  // String
    "destinations", List.of(),  // List<Object>
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
| `ai` | `Boolean` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Yes | Message to send to the recipient. |
| `credits` | `Double` | No | The number of credits used on the message. |
| `deliveryreporturl` | `String` | No | The url to which we should POST delivery reports to for this message. |
| `destination` | `String` | Yes | Telephone number of the recipient |
| `from` | `String` | No | The date-time from which you would like matching messages |
| `keyword` | `String` | No | The keyword used in the inbound message |
| `limit` | `Double` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Map<String, Object>` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `List<Object>` | No | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `String` | No | Date at which to send the message. |
| `sender` | `String` | Yes | The sender of the message. |
| `skip` | `Double` | No | The number of results you would like to ignore before returning messages. |
| `status` | `String` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `String` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `String` | No | The date-time to which you would like matching messages |
| `ttl` | `Double` | No | The optional number of minutes before the delivery report is deleted. |
| `unread` | `Boolean` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
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
| `destination` | `String` | No | The phone number of the recipient. |
| `length` | `Map<String, Object>` | No | The length of the generated passcode. |
| `metadata` | `Map<String, Object>` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String` | No | A passcode you supply for use in the message template. |
| `sender` | `String` | No | The sender of the message. |
| `template` | `String` | No | A template to use as the content for the message. |
| `validity` | `Double` | No | The length of time in seconds for which the generated passcode should be valid. |

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

