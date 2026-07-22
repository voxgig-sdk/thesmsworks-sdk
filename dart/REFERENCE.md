# Thesmsworks Dart SDK Reference

Complete API reference for the Thesmsworks Dart SDK.

## ThesmsworksSDK

### Constructor

```dart
import 'package:thesmsworks_sdk/ThesmsworksSDK.dart';

final client = ThesmsworksSDK(options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options['apikey']` | `String` | API key for authentication. |
| `options['base']` | `String` | Base URL for API requests. |
| `options['prefix']` | `String` | URL prefix appended after base. |
| `options['suffix']` | `String` | URL suffix appended after path. |
| `options['headers']` | `Map` | Custom headers for all requests. |
| `options['feature']` | `Map` | Feature configuration. |
| `options['system']` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.test([testopts, sdkopts])`

Create a test client with mock features active. Both arguments may be `null`.

```dart
final client = ThesmsworksSDK.test();
```


### Instance Methods

#### `Batch([entopts])`

Create a new `BatchEntity` instance. Pass no argument for no initial data.

#### `BatchMessage([entopts])`

Create a new `BatchMessageEntity` instance. Pass no argument for no initial data.

#### `Credit([entopts])`

Create a new `CreditEntity` instance. Pass no argument for no initial data.

#### `Flash([entopts])`

Create a new `FlashEntity` instance. Pass no argument for no initial data.

#### `Message([entopts])`

Create a new `MessageEntity` instance. Pass no argument for no initial data.

#### `OneTimePassword([entopts])`

Create a new `OneTimePasswordEntity` instance. Pass no argument for no initial data.

#### `Schedule([entopts])`

Create a new `ScheduleEntity` instance. Pass no argument for no initial data.

#### `Swagger([entopts])`

Create a new `SwaggerEntity` instance. Pass no argument for no initial data.

#### `Util([entopts])`

Create a new `UtilEntity` instance. Pass no argument for no initial data.

#### `options() -> Map`

Return a deep copy of the current SDK options.

#### `utility() -> Utility`

Return the SDK utility object.

#### `direct([fetchargs]) -> Future<Map>`

Make a direct HTTP request to any API endpoint. Returns a result `Map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `result['ok']`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs['path']` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs['method']` | `String` | HTTP method (default: `'GET'`). |
| `fetchargs['params']` | `Map` | Path parameter values. |
| `fetchargs['query']` | `Map` | Query string parameters. |
| `fetchargs['headers']` | `Map` | Request headers (merged with defaults). |
| `fetchargs['body']` | `dynamic` | Request body (maps are JSON-serialized). |

**Returns:** `Future<Map>`

#### `prepare([fetchargs]) -> Future`

Prepare a fetch definition without sending. Returns the `fetchdef` (or an error value on failure).


---

## BatchEntity

```dart
final batch = client.Batch();
```

### Operations

#### `load(reqmatch, [ctrl]) -> Future<dynamic>`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```dart
final result = await client.Batch().load({'id': 'batch_id'});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `BatchEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## BatchMessageEntity

```dart
final batch_message = client.BatchMessage();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `String` | Yes |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `List<dynamic>` | Yes |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `tag` | `String` | No |  |
| `ttl` | `num` | No |  |
| `validity` | `num` | No |  |

### Operations

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.BatchMessage().create({
  'content': 'example_content',  // String
  'destination': <dynamic>[],  // List<dynamic>
  'sender': 'example_sender',  // String
});
```

#### `remove(reqmatch, [ctrl]) -> Future<dynamic>`

Remove the entity matching the given criteria. Throws on error.

```dart
final result = await client.BatchMessage().remove({'batchid': 'batchid'});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `BatchMessageEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## CreditEntity

```dart
final credit = client.Credit();
```

### Operations

#### `load(reqmatch, [ctrl]) -> Future<dynamic>`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```dart
final result = await client.Credit().load();
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `CreditEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## FlashEntity

```dart
final flash = client.Flash();
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `FlashEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## MessageEntity

```dart
final message = client.Message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `String` | Yes |  |
| `credit` | `num` | No |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `String` | Yes |  |
| `from` | `String` | No |  |
| `keyword` | `String` | No |  |
| `limit` | `num` | No |  |
| `metadata` | `Map<String, dynamic>` | No |  |
| `responseemail` | `List<dynamic>` | No |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `skip` | `num` | No |  |
| `status` | `String` | No |  |
| `tag` | `String` | No |  |
| `to` | `String` | No |  |
| `ttl` | `num` | No |  |
| `unread` | `bool` | No |  |
| `validity` | `num` | No |  |

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

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.Message().create({
  'content': 'example_content',  // String
  'destination': 'example_destination',  // String
  'sender': 'example_sender',  // String
});
```

#### `load(reqmatch, [ctrl]) -> Future<dynamic>`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```dart
final result = await client.Message().load({'id': 'message_id'});
```

#### `remove(reqmatch, [ctrl]) -> Future<dynamic>`

Remove the entity matching the given criteria. Throws on error.

```dart
final result = await client.Message().remove({'id': 'message_id'});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `MessageEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## OneTimePasswordEntity

```dart
final one_time_password = client.OneTimePassword();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No |  |
| `length` | `Map<String, dynamic>` | No |  |
| `metadata` | `Map<String, dynamic>` | No |  |
| `passcode` | `String` | No |  |
| `sender` | `String` | No |  |
| `template` | `String` | No |  |
| `validity` | `num` | No |  |

### Operations

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.OneTimePassword().create({
});
```

#### `load(reqmatch, [ctrl]) -> Future<dynamic>`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```dart
final result = await client.OneTimePassword().load({'messageid': 'messageid'});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `OneTimePasswordEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## ScheduleEntity

```dart
final schedule = client.Schedule();
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `ScheduleEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## SwaggerEntity

```dart
final swagger = client.Swagger();
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `SwaggerEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## UtilEntity

```dart
final util = client.Util();
```

### Operations

#### `load(reqmatch, [ctrl]) -> Future<dynamic>`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```dart
final result = await client.Util().load({'errorcode': 'errorcode'});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `UtilEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```dart
final client = ThesmsworksSDK({
  'feature': {
    'test': {'active': true},
  },
});
```

