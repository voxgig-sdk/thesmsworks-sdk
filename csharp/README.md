# Thesmsworks C# SDK



The C# SDK for the Thesmsworks API — an entity-oriented client following idiomatic C# conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Batch()` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to NuGet. Install it from the GitHub
release tag (`csharp/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)) or
from a source checkout — build the library and add a project reference:

```bash
cd csharp && dotnet build ThesmsworksSDK.csproj
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```csharp
using ThesmsworksSdk;

var client = new ThesmsworksSDK(new Dictionary<string, object?>
{
    ["apikey"] = Environment.GetEnvironmentVariable("THESMSWORKS_APIKEY"),
});
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`Load()` returns the bare record (as `object?`) and raises on error.

```csharp
try
{
    var oneTimePassword = client.OneTimePassword().Load(new Dictionary<string, object?> { ["messageid"] = "example_messageid" });
    Console.WriteLine(oneTimePassword);
}
catch (Exception err)
{
    Console.WriteLine($"load failed: {err.Message}");
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const credit = await client.Credit().load()
  console.log(credit)
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

```csharp
var result = client.Direct(new Dictionary<string, object?>
{
    ["path"] = "/api/resource/{id}",
    ["method"] = "GET",
    ["params"] = new Dictionary<string, object?> { ["id"] = "example" },
});

if (Equals(result["ok"], true))
{
    Console.WriteLine(result["status"]);  // 200
    Console.WriteLine(result["data"]);    // response body
}
else
{
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // read both with TryGetValue rather than indexing a key that may be absent.
    result.TryGetValue("status", out var status);
    result.TryGetValue("err", out var err);
    Console.WriteLine($"{status} {err}");
}
```

### Prepare a request without sending it

```csharp
// Prepare() returns the fetch definition and raises on error.
var fetchdef = client.Prepare(new Dictionary<string, object?>
{
    ["path"] = "/api/resource/{id}",
    ["method"] = "DELETE",
    ["params"] = new Dictionary<string, object?> { ["id"] = "example" },
});

Console.WriteLine(fetchdef["url"]);
Console.WriteLine(fetchdef["method"]);
Console.WriteLine(fetchdef["headers"]);
```

### Use test mode

Create a mock client for unit testing — no server required:

```csharp
var client = ThesmsworksSDK.TestSDK(null, null);

// Entity ops return the bare record and raise on error.
var credit = client.Credit().Load(null);
// credit holds the mock response record
Console.WriteLine(credit);
```

### Use a custom fetch function

Replace the HTTP transport with your own delegate:

```csharp
Func<string, Dictionary<string, object?>, Dictionary<string, object?>> mockFetch =
    (url, init) => new Dictionary<string, object?>
    {
        ["status"] = 200,
        ["statusText"] = "OK",
        ["headers"] = new Dictionary<string, object?>(),
        ["json"] = (Func<object?>)(() => new Dictionary<string, object?> { ["id"] = "mock01" }),
    };

var client = new ThesmsworksSDK(new Dictionary<string, object?>
{
    ["base"] = "http://localhost:8080",
    ["system"] = new Dictionary<string, object?>
    {
        ["fetch"] = mockFetch,
    },
});
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd csharp && dotnet test
```


## Reference

### ThesmsworksSDK

```csharp
using ThesmsworksSdk;

var client = new ThesmsworksSDK(options);
```

Creates a new SDK client. `options` is a `Dictionary<string, object?>`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `Dictionary` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Dictionary` | System overrides (e.g. custom `fetch` delegate). |

### TestSDK

```csharp
var client = ThesmsworksSDK.TestSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() -> Dictionary` | Deep copy of current SDK options. |
| `GetUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs) -> Dictionary` | Build an HTTP request definition without sending. Raises on error. |
| `Direct` | `(fetchargs) -> Dictionary` | Build and send an HTTP request. Returns a result dictionary (branch on `ok`). |
| `Batch` | `(entopts) -> ThesmsworksEntityBase` | Create a Batch entity instance. |
| `BatchMessage` | `(entopts) -> ThesmsworksEntityBase` | Create a BatchMessage entity instance. |
| `Credit` | `(entopts) -> ThesmsworksEntityBase` | Create a Credit entity instance. |
| `Flash` | `(entopts) -> ThesmsworksEntityBase` | Create a Flash entity instance. |
| `Message` | `(entopts) -> ThesmsworksEntityBase` | Create a Message entity instance. |
| `OneTimePassword` | `(entopts) -> ThesmsworksEntityBase` | Create an OneTimePassword entity instance. |
| `Schedule` | `(entopts) -> ThesmsworksEntityBase` | Create a Schedule entity instance. |
| `Swagger` | `(entopts) -> ThesmsworksEntityBase` | Create a Swagger entity instance. |
| `Util` | `(entopts) -> ThesmsworksEntityBase` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl) -> object?` | Load a single entity by match criteria. Raises on error. |
| `Create` | `(reqdata, ctrl) -> object?` | Create a new entity. Raises on error. |
| `Remove` | `(reqmatch, ctrl) -> object?` | Remove an entity. Raises on error. |
| `Data` | `(newdata) -> object?` | Get or set entity data. |
| `Match` | `(newmatch) -> object?` | Get or set entity match criteria. |
| `Make` | `() -> IEntity` | Create a new instance with the same options. |
| `GetName` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `Dictionary` for
single-entity ops, an aggregate list for `List`) as `object?` and raise on
error. Wrap calls in `try`/`catch` to handle failures.

The `Direct()` escape hatch never raises — it returns a result
`Dictionary<string, object?>` you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Dictionary` | Response headers. |
| `data` | `object?` | Parsed JSON response body. |

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

Create an instance: `var batch = client.Batch();`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match)` | Load a single entity by match criteria. |

#### Example: Load

```csharp
var batch = client.Batch().Load(new Dictionary<string, object?> { ["id"] = "batch_id" });
```


### BatchMessage

Create an instance: `var batchMessage = client.BatchMessage();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `Remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Message to send to the recipient |
| `deliveryreporturl` | `string` | The url to which we should POST delivery reports to for this message. |
| `destinations` | `List<object?>` | Telephone numbers of each of the recipients |
| `schedule` | `string` | Date-time at which to send the batch. |
| `sender` | `string` | The sender of the message. |
| `tag` | `string` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `double` | The number of minutes before the delivery report is deleted. |
| `validity` | `double` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Create

```csharp
var batchMessage = client.BatchMessage().Create(new Dictionary<string, object?>
{
    ["content"] = "example_content",  // string
    ["destinations"] = new List<object?>(),  // List<object?>
    ["sender"] = "example_sender",  // string
});
```


### Credit

Create an instance: `var credit = client.Credit();`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match)` | Load a single entity by match criteria. |

#### Example: Load

```csharp
var credit = client.Credit().Load(null);
```


### Flash

Create an instance: `var flash = client.Flash();`


### Message

Create an instance: `var message = client.Message();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `Load(match)` | Load a single entity by match criteria. |
| `Remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Message to send to the recipient. |
| `credits` | `double` | The number of credits used on the message. |
| `deliveryreporturl` | `string` | The url to which we should POST delivery reports to for this message. |
| `destination` | `string` | Telephone number of the recipient |
| `from` | `string` | The date-time from which you would like matching messages |
| `keyword` | `string` | The keyword used in the inbound message |
| `limit` | `double` | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Dictionary<string, object?>` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `List<object?>` | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `string` | Date at which to send the message. |
| `sender` | `string` | The sender of the message. |
| `skip` | `double` | The number of results you would like to ignore before returning messages. |
| `status` | `string` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `string` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `string` | The date-time to which you would like matching messages |
| `ttl` | `double` | The optional number of minutes before the delivery report is deleted. |
| `unread` | `bool` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `double` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Load

```csharp
var message = client.Message().Load(new Dictionary<string, object?> { ["id"] = "message_id" });
```

#### Example: Create

```csharp
var message = client.Message().Create(new Dictionary<string, object?>
{
    ["content"] = "example_content",  // string
    ["destination"] = "example_destination",  // string
    ["sender"] = "example_sender",  // string
});
```


### OneTimePassword

Create an instance: `var oneTimePassword = client.OneTimePassword();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `Load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `string` | The phone number of the recipient. |
| `length` | `Dictionary<string, object?>` | The length of the generated passcode. |
| `metadata` | `Dictionary<string, object?>` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `string` | A passcode you supply for use in the message template. |
| `sender` | `string` | The sender of the message. |
| `template` | `string` | A template to use as the content for the message. |
| `validity` | `double` | The length of time in seconds for which the generated passcode should be valid. |

#### Example: Load

```csharp
var oneTimePassword = client.OneTimePassword().Load(new Dictionary<string, object?> { ["messageid"] = "messageid" });
```

#### Example: Create

```csharp
var oneTimePassword = client.OneTimePassword().Create(new Dictionary<string, object?>
{
});
```


### Schedule

Create an instance: `var schedule = client.Schedule();`


### Swagger

Create an instance: `var swagger = client.Swagger();`


### Util

Create an instance: `var util = client.Util();`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match)` | Load a single entity by match criteria. |

#### Example: Load

```csharp
var util = client.Util().Load(new Dictionary<string, object?> { ["errorcode"] = "errorcode" });
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

### Data as dictionaries

The C# SDK uses a loose object model — `Dictionary<string, object?>`
throughout — rather than a bespoke typed class per endpoint. This mirrors
the dynamic nature of the API and keeps the SDK flexible: no regeneration is
needed when the API schema changes.

Use `Helpers.ToMapAny(value)` to safely coerce a value to a
`Dictionary<string, object?>`. A `ThesmsworksTypes.cs` module of
reference `record` types is also generated for editor documentation.

### Project structure

```
csharp/
├── ThesmsworksSDK.csproj    -- Library project (compiles everything except test/)
├── core/                       -- Main SDK client, config, entity base, error type
├── entity/                     -- Entity implementations
├── feature/                    -- Built-in features (Base, Test, Log, ...)
├── utility/                    -- Utility functions and the vendored struct library
└── test/                       -- xUnit test suites
```

The main client class (`ThesmsworksSDK`, namespace
`ThesmsworksSdk`) exposes the entity accessors. Reference entity or
utility types directly only when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const credit = client.Credit()
await credit.load()

// credit.data() now returns the credit data from the last `load`
// credit.match() returns the last match criteria
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
