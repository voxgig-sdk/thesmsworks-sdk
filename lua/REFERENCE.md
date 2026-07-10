# Thesmsworks Lua SDK Reference

Complete API reference for the Thesmsworks Lua SDK.


## ThesmsworksSDK

### Constructor

```lua
local sdk = require("thesmsworks_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `Batch(data)`

Create a new `Batch` entity instance. Pass `nil` for no initial data.

#### `BatchMessage(data)`

Create a new `BatchMessage` entity instance. Pass `nil` for no initial data.

#### `Credit(data)`

Create a new `Credit` entity instance. Pass `nil` for no initial data.

#### `Flash(data)`

Create a new `Flash` entity instance. Pass `nil` for no initial data.

#### `Message(data)`

Create a new `Message` entity instance. Pass `nil` for no initial data.

#### `OneTimePassword(data)`

Create a new `OneTimePassword` entity instance. Pass `nil` for no initial data.

#### `Schedule(data)`

Create a new `Schedule` entity instance. Pass `nil` for no initial data.

#### `Swagger(data)`

Create a new `Swagger` entity instance. Pass `nil` for no initial data.

#### `Util(data)`

Create a new `Util` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## BatchEntity

```lua
local batch = client:Batch(nil)
```

### Operations

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Batch():load({ id = "batch_id" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## BatchMessageEntity

```lua
local batch_message = client:BatchMessage(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean` | No |  |
| `content` | `string` | Yes |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `table` | Yes |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `tag` | `string` | No |  |
| `ttl` | `number` | No |  |
| `validity` | `number` | No |  |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:BatchMessage():create({
  content = --[[ string ]],
  destination = --[[ table ]],
  sender = --[[ string ]],
})
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:BatchMessage():remove({ batchid = "batchid" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchMessageEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CreditEntity

```lua
local credit = client:Credit(nil)
```

### Operations

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Credit():load()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CreditEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## FlashEntity

```lua
local flash = client:Flash(nil)
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `FlashEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## MessageEntity

```lua
local message = client:Message(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean` | No |  |
| `content` | `string` | Yes |  |
| `credit` | `number` | No |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `string` | Yes |  |
| `from` | `string` | No |  |
| `keyword` | `string` | No |  |
| `limit` | `number` | No |  |
| `metadata` | `table` | No |  |
| `responseemail` | `table` | No |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `skip` | `number` | No |  |
| `status` | `string` | No |  |
| `tag` | `string` | No |  |
| `to` | `string` | No |  |
| `ttl` | `number` | No |  |
| `unread` | `boolean` | No |  |
| `validity` | `number` | No |  |

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

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Message():create({
  content = --[[ string ]],
  destination = --[[ string ]],
  sender = --[[ string ]],
})
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Message():load({ id = "message_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Message():remove({ id = "message_id" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MessageEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## OneTimePasswordEntity

```lua
local one_time_password = client:OneTimePassword(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `string` | No |  |
| `length` | `table` | No |  |
| `metadata` | `table` | No |  |
| `passcode` | `string` | No |  |
| `sender` | `string` | No |  |
| `template` | `string` | No |  |
| `validity` | `number` | No |  |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:OneTimePassword():create({
})
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:OneTimePassword():load({ messageid = "messageid" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `OneTimePasswordEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ScheduleEntity

```lua
local schedule = client:Schedule(nil)
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SwaggerEntity

```lua
local swagger = client:Swagger(nil)
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SwaggerEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## UtilEntity

```lua
local util = client:Util(nil)
```

### Operations

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Util():load({ errorcode = "errorcode" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `UtilEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```lua
local client = sdk.new({
  feature = {
    test = { active = true },
  },
})
```

