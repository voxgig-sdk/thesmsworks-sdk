# Thesmsworks Rust SDK Reference

Complete API reference for the Thesmsworks Rust SDK.


## ThesmsworksSDK

### Constructor

```rust
use thesmsworks_sdk::{ThesmsworksSDK, Value};

let client = ThesmsworksSDK::new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`Value::Noval` for none).

**Parameters:**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Static Functions

#### `test_sdk(testopts: Value, sdkopts: Value) -> Rc<ThesmsworksSDK>`

Create a test client with mock features active. Both arguments may be
`Value::Noval`.

```rust
use thesmsworks_sdk::{test_sdk, Value};

let client = test_sdk(Value::Noval, Value::Noval);
```


### Instance Methods

#### `batch(entopts: Value) -> Rc<BatchEntity>`

Create a new `BatchEntity` instance. Pass `Value::Noval` for no
initial options.

#### `batch_message(entopts: Value) -> Rc<BatchMessageEntity>`

Create a new `BatchMessageEntity` instance. Pass `Value::Noval` for no
initial options.

#### `credit(entopts: Value) -> Rc<CreditEntity>`

Create a new `CreditEntity` instance. Pass `Value::Noval` for no
initial options.

#### `flash(entopts: Value) -> Rc<FlashEntity>`

Create a new `FlashEntity` instance. Pass `Value::Noval` for no
initial options.

#### `message(entopts: Value) -> Rc<MessageEntity>`

Create a new `MessageEntity` instance. Pass `Value::Noval` for no
initial options.

#### `one_time_password(entopts: Value) -> Rc<OneTimePasswordEntity>`

Create a new `OneTimePasswordEntity` instance. Pass `Value::Noval` for no
initial options.

#### `schedule(entopts: Value) -> Rc<ScheduleEntity>`

Create a new `ScheduleEntity` instance. Pass `Value::Noval` for no
initial options.

#### `swagger(entopts: Value) -> Rc<SwaggerEntity>`

Create a new `SwaggerEntity` instance. Pass `Value::Noval` for no
initial options.

#### `util(entopts: Value) -> Rc<UtilEntity>`

Create a new `UtilEntity` instance. Pass `Value::Noval` for no
initial options.

#### `options_map() -> Value`

Return a deep copy of the current SDK options.

#### `get_utility() -> Rc<Utility>`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) -> Result<Value, ThesmsworksError>`

Make a direct HTTP request to any API endpoint. `Ok` is a result `Value::Map`
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch resolves to `Ok` even on a non-2xx response — branch on
`getp(&result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) -> Result<Value, ThesmsworksError>`

Prepare a fetch definition without sending. Returns the fetchdef on `Ok`.


---

## BatchEntity

```rust
let batch = client.batch(Value::Noval);
```

### Operations

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.batch(Value::Noval).load(jo(vec![("id", Value::str("batch_id"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `BatchEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## BatchMessageEntity

```rust
let batch_message = client.batch_message(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `String` | Yes |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `Vec<Value>` | Yes |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `tag` | `String` | No |  |
| `ttl` | `f64` | No |  |
| `validity` | `f64` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.batch_message(Value::Noval).create(jo(vec![
    ("content", Value::str("example_content")),  // String
    ("destination", Value::empty_list()),  // Vec<Value>
    ("sender", Value::str("example_sender")),  // String
]), Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.batch_message(Value::Noval).remove(jo(vec![("batchid", Value::str("batchid"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `BatchMessageEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## CreditEntity

```rust
let credit = client.credit(Value::Noval);
```

### Operations

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.credit(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `CreditEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## FlashEntity

```rust
let flash = client.flash(Value::Noval);
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `FlashEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## MessageEntity

```rust
let message = client.message(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `String` | Yes |  |
| `credit` | `f64` | No |  |
| `deliveryreporturl` | `String` | No |  |
| `destination` | `String` | Yes |  |
| `from` | `String` | No |  |
| `keyword` | `String` | No |  |
| `limit` | `f64` | No |  |
| `metadata` | `Value` | No |  |
| `responseemail` | `Vec<Value>` | No |  |
| `schedule` | `String` | No |  |
| `sender` | `String` | Yes |  |
| `skip` | `f64` | No |  |
| `status` | `String` | No |  |
| `tag` | `String` | No |  |
| `to` | `String` | No |  |
| `ttl` | `f64` | No |  |
| `unread` | `bool` | No |  |
| `validity` | `f64` | No |  |

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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.message(Value::Noval).create(jo(vec![
    ("content", Value::str("example_content")),  // String
    ("destination", Value::str("example_destination")),  // String
    ("sender", Value::str("example_sender")),  // String
]), Value::Noval).unwrap();
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.message(Value::Noval).load(jo(vec![("id", Value::str("message_id"))]), Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.message(Value::Noval).remove(jo(vec![("id", Value::str("message_id"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `MessageEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## OneTimePasswordEntity

```rust
let one_time_password = client.one_time_password(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `String` | No |  |
| `length` | `Value` | No |  |
| `metadata` | `Value` | No |  |
| `passcode` | `String` | No |  |
| `sender` | `String` | No |  |
| `template` | `String` | No |  |
| `validity` | `f64` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.one_time_password(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.one_time_password(Value::Noval).load(jo(vec![("messageid", Value::str("messageid"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `OneTimePasswordEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ScheduleEntity

```rust
let schedule = client.schedule(Value::Noval);
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ScheduleEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SwaggerEntity

```rust
let swagger = client.swagger(Value::Noval);
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SwaggerEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## UtilEntity

```rust
let util = client.util(Value::Noval);
```

### Operations

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, ThesmsworksError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.util(Value::Noval).load(jo(vec![("errorcode", Value::str("errorcode"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `UtilEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```rust
let client = ThesmsworksSDK::new(jo(vec![
    ("feature", jo(vec![
        ("test", jo(vec![("active", Value::Bool(true))])),
    ])),
]));
```

