# Thesmsworks C++ SDK Reference

Complete API reference for the Thesmsworks C++ SDK.


## ThesmsworksSDK

### Constructor

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<ThesmsworksSDK>(options);
```

Create a new SDK client instance. `options` is an `sdk::Value` map.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Value` | SDK configuration options (a map). |
| `options["apikey"]` | `std::string` | API key for authentication. |
| `options["base"]` | `std::string` | Base URL for API requests. |
| `options["prefix"]` | `std::string` | URL prefix appended after base. |
| `options["suffix"]` | `std::string` | URL suffix appended after path. |
| `options["headers"]` | `Value` | Custom headers for all requests. |
| `options["feature"]` | `Value` | Feature configuration. |
| `options["system"]` | `Value` | System overrides. |


### Static Methods

#### `ThesmsworksSDK::testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be
`Value::undef()`; a no-arg overload is also provided.

```cpp
auto client = ThesmsworksSDK::testSDK();
```


### Instance Methods

#### `batch(entopts = Value::undef()) -> std::shared_ptr<BatchEntity>`

Create a new `BatchEntity` instance bound to this client.

#### `batch_message(entopts = Value::undef()) -> std::shared_ptr<BatchMessageEntity>`

Create a new `BatchMessageEntity` instance bound to this client.

#### `credit(entopts = Value::undef()) -> std::shared_ptr<CreditEntity>`

Create a new `CreditEntity` instance bound to this client.

#### `flash(entopts = Value::undef()) -> std::shared_ptr<FlashEntity>`

Create a new `FlashEntity` instance bound to this client.

#### `message(entopts = Value::undef()) -> std::shared_ptr<MessageEntity>`

Create a new `MessageEntity` instance bound to this client.

#### `one_time_password(entopts = Value::undef()) -> std::shared_ptr<OneTimePasswordEntity>`

Create a new `OneTimePasswordEntity` instance bound to this client.

#### `schedule(entopts = Value::undef()) -> std::shared_ptr<ScheduleEntity>`

Create a new `ScheduleEntity` instance bound to this client.

#### `swagger(entopts = Value::undef()) -> std::shared_ptr<SwaggerEntity>`

Create a new `SwaggerEntity` instance bound to this client.

#### `util(entopts = Value::undef()) -> std::shared_ptr<UtilEntity>`

Create a new `UtilEntity` instance bound to this client.

#### `optionsMap() -> Value`

Return a deep copy of the current SDK options.

#### `getUtility() -> UtilityPtr`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `getp(result, "ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `std::string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `std::string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Value` | Path parameter values. |
| `fetchargs["query"]` | `Value` | Query string parameters. |
| `fetchargs["headers"]` | `Value` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `Value` (result map)

#### `prepare(fetchargs) -> Value`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## BatchEntity

```cpp
auto batch = client->batch();
```

### Operations

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->batch()->load(vmap({{"id", Value("batch_id")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `BatchEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## BatchMessageEntity

```cpp
auto batch_message = client->batch_message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `std::string` | Yes |  |
| `deliveryreporturl` | `std::string` | No |  |
| `destination` | `std::vector<sdk::Value>` | Yes |  |
| `schedule` | `std::string` | No |  |
| `sender` | `std::string` | Yes |  |
| `tag` | `std::string` | No |  |
| `ttl` | `double` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->batch_message()->create(vmap({
    {"content", Value("example_content")},  // std::string
    {"destination", vlist()},  // std::vector<sdk::Value>
    {"sender", Value("example_sender")},  // std::string
}), Value::undef());
```

#### `remove(reqmatch, ctrl) -> Value`

Remove the entity matching the given criteria. Throws on error.

```cpp
Value result = client->batch_message()->remove(vmap({{"batchid", Value("batchid")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `BatchMessageEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## CreditEntity

```cpp
auto credit = client->credit();
```

### Operations

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->credit()->load(Value::undef(), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `CreditEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## FlashEntity

```cpp
auto flash = client->flash();
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `FlashEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## MessageEntity

```cpp
auto message = client->message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `std::string` | Yes |  |
| `credit` | `double` | No |  |
| `deliveryreporturl` | `std::string` | No |  |
| `destination` | `std::string` | Yes |  |
| `from` | `std::string` | No |  |
| `keyword` | `std::string` | No |  |
| `limit` | `double` | No |  |
| `metadata` | `sdk::Value` | No |  |
| `responseemail` | `std::vector<sdk::Value>` | No |  |
| `schedule` | `std::string` | No |  |
| `sender` | `std::string` | Yes |  |
| `skip` | `double` | No |  |
| `status` | `std::string` | No |  |
| `tag` | `std::string` | No |  |
| `to` | `std::string` | No |  |
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

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->message()->create(vmap({
    {"content", Value("example_content")},  // std::string
    {"destination", Value("example_destination")},  // std::string
    {"sender", Value("example_sender")},  // std::string
}), Value::undef());
```

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->message()->load(vmap({{"id", Value("message_id")}}), Value::undef());
```

#### `remove(reqmatch, ctrl) -> Value`

Remove the entity matching the given criteria. Throws on error.

```cpp
Value result = client->message()->remove(vmap({{"id", Value("message_id")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `MessageEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## OneTimePasswordEntity

```cpp
auto one_time_password = client->one_time_password();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `std::string` | No |  |
| `length` | `sdk::Value` | No |  |
| `metadata` | `sdk::Value` | No |  |
| `passcode` | `std::string` | No |  |
| `sender` | `std::string` | No |  |
| `template` | `std::string` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->one_time_password()->create(vmap({
}), Value::undef());
```

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->one_time_password()->load(vmap({{"messageid", Value("messageid")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `OneTimePasswordEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ScheduleEntity

```cpp
auto schedule = client->schedule();
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ScheduleEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SwaggerEntity

```cpp
auto swagger = client->swagger();
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SwaggerEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## UtilEntity

```cpp
auto util = client->util();
```

### Operations

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->util()->load(vmap({{"errorcode", Value("errorcode")}}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `UtilEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```cpp
auto client = std::make_shared<ThesmsworksSDK>(vmap({
    {"feature", vmap({
        {"test", vmap({{"active", Value(true)}})},
    })},
}));
```

