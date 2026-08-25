# Thesmsworks Python SDK Reference

Complete API reference for the Thesmsworks Python SDK.


## ThesmsworksSDK

### Constructor

```python
from thesmsworks_sdk import ThesmsworksSDK

client = ThesmsworksSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = ThesmsworksSDK.test()
```


### Instance Methods

#### `Batch(data=None)`

Create a new `BatchEntity` instance. Pass `None` for no initial data.

#### `BatchMessage(data=None)`

Create a new `BatchMessageEntity` instance. Pass `None` for no initial data.

#### `Credit(data=None)`

Create a new `CreditEntity` instance. Pass `None` for no initial data.

#### `Flash(data=None)`

Create a new `FlashEntity` instance. Pass `None` for no initial data.

#### `Message(data=None)`

Create a new `MessageEntity` instance. Pass `None` for no initial data.

#### `OneTimePassword(data=None)`

Create a new `OneTimePasswordEntity` instance. Pass `None` for no initial data.

#### `Schedule(data=None)`

Create a new `ScheduleEntity` instance. Pass `None` for no initial data.

#### `Swagger(data=None)`

Create a new `SwaggerEntity` instance. Pass `None` for no initial data.

#### `Util(data=None)`

Create a new `UtilEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## BatchEntity

```python
batch = client.Batch()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `str` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Batch().load({"id": "batch_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## BatchMessageEntity

```python
batch_message = client.BatchMessage()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `str` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `str` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `list` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `str` | No | Date-time at which to send the batch. |
| `sender` | `str` | Yes | The sender of the message. |
| `tag` | `str` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `float` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `float` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.BatchMessage().create({
    "content": "example_content",  # str
    "destinations": [],  # list
    "sender": "example_sender",  # str
})
```

#### `remove(reqmatch, ctrl=None) -> dict`

Remove the entity matching the given criteria. Raises on error.

```python
result = client.BatchMessage().remove({"batchid": "batchid"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `BatchMessageEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CreditEntity

```python
credit = client.Credit()
```

### Operations

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Credit().load()
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CreditEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## FlashEntity

```python
flash = client.Flash()
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `FlashEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MessageEntity

```python
message = client.Message()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `str` | Yes | Message to send to the recipient. |
| `credits` | `float` | No | The number of credits used on the message. |
| `deliveryreporturl` | `str` | No | The url to which we should POST delivery reports to for this message. |
| `destination` | `str` | Yes | Telephone number of the recipient |
| `from` | `str` | No | The date-time from which you would like matching messages |
| `id` | `str` | No |  |
| `keyword` | `str` | No | The keyword used in the inbound message |
| `limit` | `float` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `dict` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `list` | No | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `str` | No | Date at which to send the message. |
| `sender` | `str` | Yes | The sender of the message. |
| `skip` | `float` | No | The number of results you would like to ignore before returning messages. |
| `status` | `str` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `str` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `str` | No | The date-time to which you would like matching messages |
| `ttl` | `float` | No | The optional number of minutes before the delivery report is deleted. |
| `unread` | `bool` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `float` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Field Usage by Operation

| Field | load | create | remove |
| --- | --- | --- | --- |
| `ai` | - | - | - |
| `content` | - | - | - |
| `credits` | - | - | - |
| `deliveryreporturl` | - | - | - |
| `destination` | - | Yes | - |
| `from` | - | - | - |
| `id` | - | - | - |
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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Message().create({
    "content": "example_content",  # str
    "destination": "example_destination",  # str
    "sender": "example_sender",  # str
})
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Message().load({"id": "message_id"})
```

#### `remove(reqmatch, ctrl=None) -> dict`

Remove the entity matching the given criteria. Raises on error.

```python
result = client.Message().remove({"id": "message_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MessageEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## OneTimePasswordEntity

```python
one_time_password = client.OneTimePassword()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `str` | No | The phone number of the recipient. |
| `length` | `dict` | No | The length of the generated passcode. |
| `metadata` | `dict` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `str` | No | A passcode you supply for use in the message template. |
| `sender` | `str` | No | The sender of the message. |
| `template` | `str` | No | A template to use as the content for the message. |
| `validity` | `float` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.OneTimePassword().create({
})
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.OneTimePassword().load({"messageid": "messageid"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `OneTimePasswordEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ScheduleEntity

```python
schedule = client.Schedule()
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ScheduleEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SwaggerEntity

```python
swagger = client.Swagger()
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SwaggerEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## UtilEntity

```python
util = client.Util()
```

### Operations

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Util().load({"errorcode": "errorcode"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `UtilEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = ThesmsworksSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

