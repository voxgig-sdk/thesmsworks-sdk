# Thesmsworks Ruby SDK Reference

Complete API reference for the Thesmsworks Ruby SDK.


## ThesmsworksSDK

### Constructor

```ruby
require_relative 'Thesmsworks_sdk'

client = ThesmsworksSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = ThesmsworksSDK.test
```


### Instance Methods

#### `Batch(data = nil)`

Create a new `Batch` entity instance. Pass `nil` for no initial data.

#### `BatchMessage(data = nil)`

Create a new `BatchMessage` entity instance. Pass `nil` for no initial data.

#### `Credit(data = nil)`

Create a new `Credit` entity instance. Pass `nil` for no initial data.

#### `Flash(data = nil)`

Create a new `Flash` entity instance. Pass `nil` for no initial data.

#### `Message(data = nil)`

Create a new `Message` entity instance. Pass `nil` for no initial data.

#### `OneTimePassword(data = nil)`

Create a new `OneTimePassword` entity instance. Pass `nil` for no initial data.

#### `Schedule(data = nil)`

Create a new `Schedule` entity instance. Pass `nil` for no initial data.

#### `Swagger(data = nil)`

Create a new `Swagger` entity instance. Pass `nil` for no initial data.

#### `Util(data = nil)`

Create a new `Util` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## BatchEntity

```ruby
batch = client.Batch
```

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Batch.load({ "id" => "batch_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `BatchEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## BatchMessageEntity

```ruby
batch_message = client.BatchMessage
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `Boolean` | No |  |
| `content` | `String` | Yes |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `Array` | Yes |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `tag` | `String` | No |  |
| `ttl` | `Float` | No |  |
| `validity` | `Float` | No |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.BatchMessage.create({
  "content" => "example_content", # String
  "destination" => [], # Array
  "sender" => "example_sender", # String
})
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.BatchMessage.remove({ "batchid" => "batchid" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `BatchMessageEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CreditEntity

```ruby
credit = client.Credit
```

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Credit.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CreditEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## FlashEntity

```ruby
flash = client.Flash
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `FlashEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## MessageEntity

```ruby
message = client.Message
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `Boolean` | No |  |
| `content` | `String` | Yes |  |
| `credit` | `Float` | No |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `String` | Yes |  |
| `from` | `String` | No |  |
| `keyword` | `String` | No |  |
| `limit` | `Float` | No |  |
| `metadata` | `Hash` | No |  |
| `responseemail` | `Array` | No |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `skip` | `Float` | No |  |
| `status` | `String` | No |  |
| `tag` | `String` | No |  |
| `to` | `String` | No |  |
| `ttl` | `Float` | No |  |
| `unread` | `Boolean` | No |  |
| `validity` | `Float` | No |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Message.create({
  "content" => "example_content", # String
  "destination" => "example_destination", # String
  "sender" => "example_sender", # String
})
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Message.load({ "id" => "message_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Message.remove({ "id" => "message_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `MessageEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## OneTimePasswordEntity

```ruby
one_time_password = client.OneTimePassword
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No |  |
| `length` | `Hash` | No |  |
| `metadata` | `Hash` | No |  |
| `passcode` | `String` | No |  |
| `sender` | `String` | No |  |
| `template` | `String` | No |  |
| `validity` | `Float` | No |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.OneTimePassword.create({
})
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.OneTimePassword.load({ "messageid" => "messageid" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `OneTimePasswordEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ScheduleEntity

```ruby
schedule = client.Schedule
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SwaggerEntity

```ruby
swagger = client.Swagger
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SwaggerEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## UtilEntity

```ruby
util = client.Util
```

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Util.load({ "errorcode" => "errorcode" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `UtilEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = ThesmsworksSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

