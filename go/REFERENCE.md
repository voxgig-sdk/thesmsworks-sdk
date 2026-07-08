# Thesmsworks Golang SDK Reference

Complete API reference for the Thesmsworks Golang SDK.


## ThesmsworksSDK

### Constructor

```go
func NewThesmsworksSDK(options map[string]any) *ThesmsworksSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *ThesmsworksSDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *ThesmsworksSDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Batch(data map[string]any) ThesmsworksEntity`

Create a new `Batch` entity instance. Pass `nil` for no initial data.

#### `BatchMessage(data map[string]any) ThesmsworksEntity`

Create a new `BatchMessage` entity instance. Pass `nil` for no initial data.

#### `Credit(data map[string]any) ThesmsworksEntity`

Create a new `Credit` entity instance. Pass `nil` for no initial data.

#### `Flash(data map[string]any) ThesmsworksEntity`

Create a new `Flash` entity instance. Pass `nil` for no initial data.

#### `Message(data map[string]any) ThesmsworksEntity`

Create a new `Message` entity instance. Pass `nil` for no initial data.

#### `OneTimePassword(data map[string]any) ThesmsworksEntity`

Create a new `OneTimePassword` entity instance. Pass `nil` for no initial data.

#### `Schedule(data map[string]any) ThesmsworksEntity`

Create a new `Schedule` entity instance. Pass `nil` for no initial data.

#### `Swagger(data map[string]any) ThesmsworksEntity`

Create a new `Swagger` entity instance. Pass `nil` for no initial data.

#### `Util(data map[string]any) ThesmsworksEntity`

Create a new `Util` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## BatchEntity

```go
batch := client.Batch(nil)
fmt.Println(batch.GetName()) // "batch"
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Batch(nil).Load(map[string]any{"id": "batch_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `BatchEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## BatchMessageEntity

```go
batchMessage := client.BatchMessage(nil)
fmt.Println(batchMessage.GetName()) // "batch_message"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `[]any` | Yes |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `tag` | `string` | No |  |
| `ttl` | `float64` | No |  |
| `validity` | `float64` | No |  |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.BatchMessage(nil).Create(map[string]any{
    "content": /* string */,
    "destination": /* []any */,
    "sender": /* string */,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

#### `Remove(reqmatch, ctrl map[string]any) (any, error)`

Remove the entity matching the given criteria.

```go
result, err := client.BatchMessage(nil).Remove(map[string]any{"batchid": "batchid"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `BatchMessageEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CreditEntity

```go
credit := client.Credit(nil)
fmt.Println(credit.GetName()) // "credit"
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Credit(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CreditEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## FlashEntity

```go
flash := client.Flash(nil)
fmt.Println(flash.GetName()) // "flash"
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `FlashEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## MessageEntity

```go
message := client.Message(nil)
fmt.Println(message.GetName()) // "message"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `credit` | `float64` | No |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `string` | Yes |  |
| `from` | `string` | No |  |
| `keyword` | `string` | No |  |
| `limit` | `float64` | No |  |
| `metadata` | `map[string]any` | No |  |
| `responseemail` | `[]any` | No |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `skip` | `float64` | No |  |
| `status` | `string` | No |  |
| `tag` | `string` | No |  |
| `to` | `string` | No |  |
| `ttl` | `float64` | No |  |
| `unread` | `bool` | No |  |
| `validity` | `float64` | No |  |

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

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Message(nil).Load(map[string]any{"id": "message_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Message(nil).Create(map[string]any{
    "content": /* string */,
    "destination": /* string */,
    "sender": /* string */,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

#### `Remove(reqmatch, ctrl map[string]any) (any, error)`

Remove the entity matching the given criteria.

```go
result, err := client.Message(nil).Remove(map[string]any{"id": "message_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `MessageEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## OneTimePasswordEntity

```go
oneTimePassword := client.OneTimePassword(nil)
fmt.Println(oneTimePassword.GetName()) // "one_time_password"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `string` | No |  |
| `length` | `map[string]any` | No |  |
| `metadata` | `map[string]any` | No |  |
| `passcode` | `string` | No |  |
| `sender` | `string` | No |  |
| `template` | `string` | No |  |
| `validity` | `float64` | No |  |

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.OneTimePassword(nil).Load(map[string]any{"messageid": "messageid"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.OneTimePassword(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `OneTimePasswordEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ScheduleEntity

```go
schedule := client.Schedule(nil)
fmt.Println(schedule.GetName()) // "schedule"
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## SwaggerEntity

```go
swagger := client.Swagger(nil)
fmt.Println(swagger.GetName()) // "swagger"
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `SwaggerEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## UtilEntity

```go
util := client.Util(nil)
fmt.Println(util.GetName()) // "util"
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Util(nil).Load(map[string]any{"errorcode": "errorcode"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `UtilEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewThesmsworksSDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

