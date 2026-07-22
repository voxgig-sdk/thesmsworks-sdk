# Thesmsworks Elixir SDK Reference

Complete API reference for the Thesmsworks Elixir SDK.


## Thesmsworks

### Constructor

```elixir
sdk = Thesmsworks.new(options)
```

Create a new SDK client. `options` is a struct value node — build one from a
native map with `Thesmsworks.Helpers.deep/1`.

**Options:**

| Name | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL for API requests. |
| `prefix` | `String.t()` | URL prefix appended after base. |
| `suffix` | `String.t()` | URL suffix appended after path. |
| `headers` | `map()` | Custom headers for all requests. |
| `feature` | `map()` | Feature configuration. |
| `system` | `map()` | System overrides (e.g. custom fetch). |


### Constructors

#### `Thesmsworks.test(testopts \\ nil, sdkopts \\ nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```elixir
sdk = Thesmsworks.test()
```


### Functions

#### `Thesmsworks.batch(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.Batch` handle.

#### `Thesmsworks.batch_message(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.BatchMessage` handle.

#### `Thesmsworks.credit(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.Credit` handle.

#### `Thesmsworks.flash(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.Flash` handle.

#### `Thesmsworks.message(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.Message` handle.

#### `Thesmsworks.one_time_password(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.OneTimePassword` handle.

#### `Thesmsworks.schedule(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.Schedule` handle.

#### `Thesmsworks.swagger(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.Swagger` handle.

#### `Thesmsworks.util(client, entopts \\ nil)`

Create a `Thesmsworks.Entity.Util` handle.

#### `options_map(client) :: map()`

Return a deep copy of the current SDK options.

#### `get_utility(client) :: map()`

Return the SDK utility node.

#### `direct(client, fetchargs) :: map()`

Make a direct HTTP request to any API endpoint. Returns a result node with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never raises — branch on `Voxgig.Struct.getprop(result, "ok")`.

**fetchargs keys:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `String.t()` | URL path with optional `{param}` placeholders. |
| `method` | `String.t()` | HTTP method (default: `"GET"`). |
| `params` | `map()` | Path parameter values. |
| `query` | `map()` | Query string parameters. |
| `headers` | `map()` | Request headers (merged with defaults). |
| `body` | `any()` | Request body (maps are JSON-serialized). |

#### `prepare(client, fetchargs) :: map()`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## Thesmsworks.Entity.Batch

```elixir
batch = Thesmsworks.batch(sdk)
```

### Operations

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Thesmsworks.Entity.Batch.load(batch, Thesmsworks.Helpers.deep(%{"id" => "batch_id"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.Batch` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.BatchMessage

```elixir
batch_message = Thesmsworks.batch_message(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean()` | No |  |
| `content` | `String.t()` | Yes |  |
| `deliveryreporturl` | `String.t()` | No |  |
| `destination` | `list()` | Yes |  |
| `schedule` | `String.t()` | No |  |
| `sender` | `String.t()` | Yes |  |
| `tag` | `String.t()` | No |  |
| `ttl` | `float()` | No |  |
| `validity` | `float()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Thesmsworks.Entity.BatchMessage.create(batch_message, Thesmsworks.Helpers.deep(%{
  "content" => "example_content",  # String.t()
  "destination" => [],  # list()
  "sender" => "example_sender",  # String.t()
}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Thesmsworks.Entity.BatchMessage.remove(batch_message, Thesmsworks.Helpers.deep(%{"batchid" => "batchid"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.BatchMessage` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.Credit

```elixir
credit = Thesmsworks.credit(sdk)
```

### Operations

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Thesmsworks.Entity.Credit.load(credit, Thesmsworks.Helpers.deep(%{}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.Credit` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.Flash

```elixir
flash = Thesmsworks.flash(sdk)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.Flash` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.Message

```elixir
message = Thesmsworks.message(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean()` | No |  |
| `content` | `String.t()` | Yes |  |
| `credit` | `float()` | No |  |
| `deliveryreporturl` | `String.t()` | No |  |
| `destination` | `String.t()` | Yes |  |
| `from` | `String.t()` | No |  |
| `keyword` | `String.t()` | No |  |
| `limit` | `float()` | No |  |
| `metadata` | `map()` | No |  |
| `responseemail` | `list()` | No |  |
| `schedule` | `String.t()` | No |  |
| `sender` | `String.t()` | Yes |  |
| `skip` | `float()` | No |  |
| `status` | `String.t()` | No |  |
| `tag` | `String.t()` | No |  |
| `to` | `String.t()` | No |  |
| `ttl` | `float()` | No |  |
| `unread` | `boolean()` | No |  |
| `validity` | `float()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Thesmsworks.Entity.Message.create(message, Thesmsworks.Helpers.deep(%{
  "content" => "example_content",  # String.t()
  "destination" => "example_destination",  # String.t()
  "sender" => "example_sender",  # String.t()
}))
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Thesmsworks.Entity.Message.load(message, Thesmsworks.Helpers.deep(%{"id" => "message_id"}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Thesmsworks.Entity.Message.remove(message, Thesmsworks.Helpers.deep(%{"id" => "message_id"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.Message` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.OneTimePassword

```elixir
one_time_password = Thesmsworks.one_time_password(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String.t()` | No |  |
| `length` | `map()` | No |  |
| `metadata` | `map()` | No |  |
| `passcode` | `String.t()` | No |  |
| `sender` | `String.t()` | No |  |
| `template` | `String.t()` | No |  |
| `validity` | `float()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Thesmsworks.Entity.OneTimePassword.create(one_time_password, Thesmsworks.Helpers.deep(%{
}))
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Thesmsworks.Entity.OneTimePassword.load(one_time_password, Thesmsworks.Helpers.deep(%{"messageid" => "messageid"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.OneTimePassword` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.Schedule

```elixir
schedule = Thesmsworks.schedule(sdk)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.Schedule` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.Swagger

```elixir
swagger = Thesmsworks.swagger(sdk)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.Swagger` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Thesmsworks.Entity.Util

```elixir
util = Thesmsworks.util(sdk)
```

### Operations

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Thesmsworks.Entity.Util.load(util, Thesmsworks.Helpers.deep(%{"errorcode" => "errorcode"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Thesmsworks.Entity.Util` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```elixir
sdk = Thesmsworks.new(Thesmsworks.Helpers.deep(%{
  "feature" => %{
    "test" => %{"active" => true},
  }
}))
```

