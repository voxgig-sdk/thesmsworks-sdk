# Thesmsworks Dart SDK



The Dart SDK for the Thesmsworks API — an entity-oriented client following idiomatic Dart conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Batch()` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to pub.dev. Add it as a git
dependency (pinned to a release tag `dart/vX.Y.Z`, see
[Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) in your `pubspec.yaml`:

```yaml
dependencies:
  thesmsworks_sdk:
    git:
      url: https://github.com/voxgig-sdk/thesmsworks-sdk
      path: dart
      ref: dart/v0.0.2
```

Or depend on a local source checkout:

```yaml
dependencies:
  thesmsworks_sdk:
    path: ../dart
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```dart
import 'dart:io';
import 'package:thesmsworks_sdk/ThesmsworksSDK.dart';

final client = ThesmsworksSDK({
  'apikey': Platform.environment['THESMSWORKS_APIKEY'],
});
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the ENTITY — call data() for the record — and throws on error.

```dart
try {
  final onetimepassword = await client.OneTimePassword().load({'messageid': 'example_messageid'});
  print(onetimepassword);
} catch (err) {
  print('load failed: $err');
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

For endpoints not covered by entity methods:

```dart
final result = await client.direct({
  'path': '/api/resource/{id}',
  'method': 'GET',
  'params': {'id': 'example'},
});

if (true == result['ok']) {
  print(result['status']);  // 200
  print(result['data']);    // response body
} else {
  // A non-2xx response carries status + data (the error body); a
  // transport-level failure carries err instead. direct() never throws —
  // branch on result['ok'].
  print(result['status']);
  print(result['err']);
}
```

### Prepare a request without sending it

```dart
// prepare() returns the fetch definition (or an error value on failure).
final fetchdef = await client.prepare({
  'path': '/api/resource/{id}',
  'method': 'DELETE',
  'params': {'id': 'example'},
});

print(fetchdef['url']);
print(fetchdef['method']);
print(fetchdef['headers']);
```

### Use test mode

Create a mock client for unit testing — no server required:

```dart
final client = ThesmsworksSDK.test();

// Entity ops return the ENTITY and throws on error;
// call data() for the record.
final batch = await client.Batch().load({'id': 'test01'});
// batch contains the mock response record
print(batch);
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```dart
Future<dynamic> mockFetch(dynamic url, dynamic init) async {
  return {
    'status': 200,
    'statusText': 'OK',
    'headers': <String, dynamic>{},
    'json': () => {'id': 'mock01'},
  };
}

final client = ThesmsworksSDK({
  'base': 'http://localhost:8080',
  'system': {
    'fetch': mockFetch,
  },
});
```

### Run live tests

Set the live-mode environment variables:

```bash
export THESMSWORKS_TEST_LIVE=TRUE
export THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd dart && dart run test/main.dart
```


## Reference

### ThesmsworksSDK

```dart
import 'package:thesmsworks_sdk/ThesmsworksSDK.dart';

final client = ThesmsworksSDK(options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Map` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Map` | System overrides (e.g. custom `fetch` function). |

### test

```dart
final client = ThesmsworksSDK.test(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options` | `() -> Map` | Deep copy of current SDK options. |
| `utility` | `() -> Utility` | The SDK utility object. |
| `prepare` | `([fetchargs]) -> Future` | Build an HTTP request definition without sending. Returns an error value on failure. |
| `direct` | `([fetchargs]) -> Future<Map>` | Build and send an HTTP request. Returns a result map (branch on `ok`); never throws. |
| `Batch` | `([entopts]) -> BatchEntity` | Create a Batch entity instance. |
| `BatchMessage` | `([entopts]) -> BatchMessageEntity` | Create a BatchMessage entity instance. |
| `Credit` | `([entopts]) -> CreditEntity` | Create a Credit entity instance. |
| `Flash` | `([entopts]) -> FlashEntity` | Create a Flash entity instance. |
| `Message` | `([entopts]) -> MessageEntity` | Create a Message entity instance. |
| `OneTimePassword` | `([entopts]) -> OneTimePasswordEntity` | Create an OneTimePassword entity instance. |
| `Schedule` | `([entopts]) -> ScheduleEntity` | Create a Schedule entity instance. |
| `Swagger` | `([entopts]) -> SwaggerEntity` | Create a Swagger entity instance. |
| `Util` | `([entopts]) -> UtilEntity` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, [ctrl]) -> Future<dynamic>` | Load a single entity by match criteria. Throws on error. |
| `create` | `(reqdata, [ctrl]) -> Future<dynamic>` | Create a new entity. Throws on error. |
| `remove` | `(reqmatch, [ctrl]) -> Future<dynamic>` | Remove an entity. Throws on error. |
| `data` | `([d]) -> Map` | Get (or, with an argument, set) entity data. |
| `match` | `([m]) -> Map` | Get (or, with an argument, set) entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `entopts` | `() -> Map` | Return the entity options. |
| `Name` | `String` | The entity name (a public field). |

### Result shape

Entity operations return the ENTITY (call data() for the record) (a `Map` for single-entity
ops, a `List` of entity instances for `list`) and throw on error. Wrap calls
in `try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `Map` you
branch on via `result['ok']`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `dynamic` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

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
| `credits` | The number of credits used on the message. |
| `destination` | The phone number of the recipient. |
| `from` | The date-time from which you would like matching messages |
| `id` |  |
| `keyword` | The keyword used in the inbound message |
| `limit` | The maximum number of messages that you would like returned in this call. |
| `metadata` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | The number of results you would like to ignore before returning messages. |
| `status` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | The date-time to which you would like matching messages |
| `unread` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

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

Create an instance: `final batch = client.Batch();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |

#### Example: Load

```dart
final batch = await client.Batch().load({'id': 'batch_id'});
```


### BatchMessage

Create an instance: `final batch_message = client.BatchMessage();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `String` | Message to send to the recipient |
| `deliveryreporturl` | `String` | The url to which we should POST delivery reports to for this message. |
| `destinations` | `List<dynamic>` | Telephone numbers of each of the recipients |
| `schedule` | `String` | Date-time at which to send the batch. |
| `sender` | `String` | The sender of the message. |
| `tag` | `String` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `num` | The number of minutes before the delivery report is deleted. |
| `validity` | `num` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Create

```dart
final batch_message = await client.BatchMessage().create({
  'content': 'example_content',  // String
  'destinations': <dynamic>[],  // List<dynamic>
  'sender': 'example_sender',  // String
});
```


### Credit

Create an instance: `final credit = client.Credit();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```dart
final credit = await client.Credit().load();
```


### Flash

Create an instance: `final flash = client.Flash();`


### Message

Create an instance: `final message = client.Message();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `credits` | `num` | The number of credits used on the message. |
| `destination` | `String` | The phone number of the recipient. |
| `from` | `String` | The date-time from which you would like matching messages |
| `id` | `String` |  |
| `keyword` | `String` | The keyword used in the inbound message |
| `limit` | `num` | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Map<String, dynamic>` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `String` | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `num` | The number of results you would like to ignore before returning messages. |
| `status` | `String` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `String` | The date-time to which you would like matching messages |
| `unread` | `bool` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

#### Example: Load

```dart
final message = await client.Message().load({'id': 'message_id'});
```

#### Example: Create

```dart
final message = await client.Message().create({
});
```


### OneTimePassword

Create an instance: `final one_time_password = client.OneTimePassword();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `String` | The phone number of the recipient. |
| `length` | `Map<String, dynamic>` | The length of the generated passcode. |
| `metadata` | `Map<String, dynamic>` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `String` | A passcode you supply for use in the message template. |
| `sender` | `String` | The sender of the message. |
| `template` | `String` | A template to use as the content for the message. |
| `validity` | `num` | The length of time in seconds for which the generated passcode should be valid. |

#### Example: Load

```dart
final one_time_password = await client.OneTimePassword().load({'messageid': 'messageid'});
```

#### Example: Create

```dart
final one_time_password = await client.OneTimePassword().create({
});
```


### Schedule

Create an instance: `final schedule = client.Schedule();`


### Swagger

Create an instance: `final swagger = client.Swagger();`


### Util

Create an instance: `final util = client.Util();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```dart
final util = await client.Util().load({'errorcode': 'errorcode'});
```

## Features

This SDK ships 8 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`debug`](#debug) | Request/response capture ring buffer for debugging |
| [`idempotency`](#idempotency) | Idempotency keys for safe retries of mutating operations |
| [`metrics`](#metrics) | Statistics capture: per-operation counters and latency |
| [`paging`](#paging) | Pagination signals for list operations |
| [`ratelimit`](#ratelimit) | Client-side rate limiting via a token bucket |
| [`retry`](#retry) | Automatic retry of transient failures with exponential backoff |
| [`test`](#test) | In-memory mock transport for testing without a live server |
| [`timeout`](#timeout) | Per-request timeout with transport abort |

> **Order matters for `ratelimit`, `retry`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### debug

Request/response capture ring buffer for debugging.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

Set `feature.debug.active` to enable it, then override any of the options above.

### idempotency

Idempotency keys for safe retries of mutating operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### metrics

Statistics capture: per-operation counters and latency.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### paging

Pagination signals for list operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Set `feature.paging.active` to enable it, then override any of the options above.

### ratelimit

Client-side rate limiting via a token bucket.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### retry

Automatic retry of transient failures with exponential backoff.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Per-request timeout with transport abort.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.


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

- **DebugFeature**: Request/response capture ring buffer for debugging
- **IdempotencyFeature**: Idempotency keys for safe retries of mutating operations
- **MetricsFeature**: Statistics capture: per-operation counters and latency
- **PagingFeature**: Pagination signals for list operations
- **RatelimitFeature**: Client-side rate limiting via a token bucket
- **RetryFeature**: Automatic retry of transient failures with exponential backoff
- **TestFeature**: In-memory mock transport for testing without a live server
- **TimeoutFeature**: Per-request timeout with transport abort

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Maps in, typed models alongside

The Dart SDK passes plain `Map<String, dynamic>` values through the
operation pipeline rather than requiring typed objects at every call. This
mirrors the dynamic nature of the API and keeps calls terse — a create is
just `create({'name': 'example'})`.

For a typed, documented view of each entity and operation, the generated
`ThesmsworksTypes.dart` provides a class per entity plus per-op request/match
classes (e.g. `Thesmsworks.fromMap(entity.data())` and `model.toMap()`), so you
can convert to and from those maps wherever you want compile-time structure.

### Package structure

```
dart/
├── lib/
│   ├── ThesmsworksSDK.dart          -- Main SDK library (exported entry point)
│   ├── ThesmsworksTypes.dart        -- Typed entity + request/match models
│   ├── ThesmsworksEntityBase.dart   -- Base class for entities
│   ├── ThesmsworksError.dart        -- SDK error type
│   ├── Config.dart              -- Configuration
│   ├── entity/                  -- Entity implementations
│   ├── feature/                 -- Built-in features (base, test, log, ...)
│   └── utility/                 -- Utility functions and vendored struct library
└── test/                        -- Test suites (dart run test/main.dart)
```

The main library (`ThesmsworksSDK.dart`) re-exports the SDK class, the typed
models, and every entity class, so a single
`import 'package:thesmsworks_sdk/ThesmsworksSDK.dart';`
brings in everything you need.

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
