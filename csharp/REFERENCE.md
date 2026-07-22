# Thesmsworks C# SDK Reference

Complete API reference for the Thesmsworks C# SDK.


## ThesmsworksSDK

### Constructor

```csharp
using ThesmsworksSdk;

var client = new ThesmsworksSDK(options);
```

Create a new SDK client instance. `options` is a
`Dictionary<string, object?>`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Dictionary` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `Dictionary` | Custom headers for all requests. |
| `options["feature"]` | `Dictionary` | Feature configuration. |
| `options["system"]` | `Dictionary` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.TestSDK(testopts = null, sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```csharp
var client = ThesmsworksSDK.TestSDK(null, null);
```


### Instance Methods

#### `Batch(entopts = null)`

Create a new `Batch` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `BatchMessage(entopts = null)`

Create a new `BatchMessage` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `Credit(entopts = null)`

Create a new `Credit` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `Flash(entopts = null)`

Create a new `Flash` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `Message(entopts = null)`

Create a new `Message` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `OneTimePassword(entopts = null)`

Create a new `OneTimePassword` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `Schedule(entopts = null)`

Create a new `Schedule` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `Swagger(entopts = null)`

Create a new `Swagger` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `Util(entopts = null)`

Create a new `Util` entity instance (returns
`ThesmsworksEntityBase`). Pass `null` for no initial options.

#### `OptionsMap() -> Dictionary`

Return a deep copy of the current SDK options.

#### `GetUtility() -> Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs = null) -> Dictionary`

Make a direct HTTP request to any API endpoint. Returns a result
`Dictionary<string, object?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Dictionary` | Path parameter values. |
| `fetchargs["query"]` | `Dictionary` | Query string parameters. |
| `fetchargs["headers"]` | `Dictionary` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `object?` | Request body (dictionaries are JSON-serialized). |

**Returns:** `Dictionary<string, object?>`

#### `Prepare(fetchargs = null) -> Dictionary`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Batch

```csharp
var batch = client.Batch();
```

### Operations

#### `Load(reqmatch, ctrl = null) -> object?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```csharp
var result = client.Batch().Load(new Dictionary<string, object?> { ["id"] = "batch_id" });
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Batch` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## BatchMessage

```csharp
var batchMessage = client.BatchMessage();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `List<object?>` | Yes |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `tag` | `string` | No |  |
| `ttl` | `double` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.BatchMessage().Create(new Dictionary<string, object?>
{
    ["content"] = "example_content",  // string
    ["destination"] = new List<object?>(),  // List<object?>
    ["sender"] = "example_sender",  // string
});
```

#### `Remove(reqmatch, ctrl = null) -> object?`

Remove the entity matching the given criteria. Raises on error.

```csharp
var result = client.BatchMessage().Remove(new Dictionary<string, object?> { ["batchid"] = "batchid" });
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `BatchMessage` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Credit

```csharp
var credit = client.Credit();
```

### Operations

#### `Load(reqmatch, ctrl = null) -> object?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```csharp
var result = client.Credit().Load(null);
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Credit` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Flash

```csharp
var flash = client.Flash();
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Flash` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Message

```csharp
var message = client.Message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `credit` | `double` | No |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `string` | Yes |  |
| `from` | `string` | No |  |
| `keyword` | `string` | No |  |
| `limit` | `double` | No |  |
| `metadata` | `Dictionary<string, object?>` | No |  |
| `responseemail` | `List<object?>` | No |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `skip` | `double` | No |  |
| `status` | `string` | No |  |
| `tag` | `string` | No |  |
| `to` | `string` | No |  |
| `ttl` | `double` | No |  |
| `unread` | `bool` | No |  |
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

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.Message().Create(new Dictionary<string, object?>
{
    ["content"] = "example_content",  // string
    ["destination"] = "example_destination",  // string
    ["sender"] = "example_sender",  // string
});
```

#### `Load(reqmatch, ctrl = null) -> object?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```csharp
var result = client.Message().Load(new Dictionary<string, object?> { ["id"] = "message_id" });
```

#### `Remove(reqmatch, ctrl = null) -> object?`

Remove the entity matching the given criteria. Raises on error.

```csharp
var result = client.Message().Remove(new Dictionary<string, object?> { ["id"] = "message_id" });
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Message` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## OneTimePassword

```csharp
var oneTimePassword = client.OneTimePassword();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `string` | No |  |
| `length` | `Dictionary<string, object?>` | No |  |
| `metadata` | `Dictionary<string, object?>` | No |  |
| `passcode` | `string` | No |  |
| `sender` | `string` | No |  |
| `template` | `string` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.OneTimePassword().Create(new Dictionary<string, object?>
{
});
```

#### `Load(reqmatch, ctrl = null) -> object?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```csharp
var result = client.OneTimePassword().Load(new Dictionary<string, object?> { ["messageid"] = "messageid" });
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `OneTimePassword` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Schedule

```csharp
var schedule = client.Schedule();
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Schedule` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Swagger

```csharp
var swagger = client.Swagger();
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Swagger` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Util

```csharp
var util = client.Util();
```

### Operations

#### `Load(reqmatch, ctrl = null) -> object?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```csharp
var result = client.Util().Load(new Dictionary<string, object?> { ["errorcode"] = "errorcode" });
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `Util` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```csharp
var client = new ThesmsworksSDK(new Dictionary<string, object?>
{
    ["feature"] = new Dictionary<string, object?>
    {
        ["test"] = new Dictionary<string, object?> { ["active"] = true },
    },
});
```

