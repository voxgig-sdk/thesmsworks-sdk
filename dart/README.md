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
      ref: dart/v0.0.1
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
`load()` returns the bare record (a `Map`) and throws on error.

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

// Entity ops return the bare record and throw on error.
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

Entity operations return the bare result data (a `Map` for single-entity
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

Create an instance: `final batch = client.Batch();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

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
| `ai` | `bool` |  |
| `content` | `String` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `List<dynamic>` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `tag` | `String` |  |
| `ttl` | `num` |  |
| `validity` | `num` |  |

#### Example: Create

```dart
final batch_message = await client.BatchMessage().create({
  'content': 'example_content',  // String
  'destination': <dynamic>[],  // List<dynamic>
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
| `ai` | `bool` |  |
| `content` | `String` |  |
| `credit` | `num` |  |
| `deliveryreporturl` | `String` |  |
| `destination` | `String` |  |
| `from` | `String` |  |
| `keyword` | `String` |  |
| `limit` | `num` |  |
| `metadata` | `Map<String, dynamic>` |  |
| `responseemail` | `List<dynamic>` |  |
| `schedule` | `String` |  |
| `sender` | `String` |  |
| `skip` | `num` |  |
| `status` | `String` |  |
| `tag` | `String` |  |
| `to` | `String` |  |
| `ttl` | `num` |  |
| `unread` | `bool` |  |
| `validity` | `num` |  |

#### Example: Load

```dart
final message = await client.Message().load({'id': 'message_id'});
```

#### Example: Create

```dart
final message = await client.Message().create({
  'content': 'example_content',  // String
  'destination': 'example_destination',  // String
  'sender': 'example_sender',  // String
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
| `destination` | `String` |  |
| `length` | `Map<String, dynamic>` |  |
| `metadata` | `Map<String, dynamic>` |  |
| `passcode` | `String` |  |
| `sender` | `String` |  |
| `template` | `String` |  |
| `validity` | `num` |  |

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
