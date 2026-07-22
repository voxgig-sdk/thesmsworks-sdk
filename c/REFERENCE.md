# Thesmsworks C SDK Reference

Complete API reference for the Thesmsworks C SDK.


## ThesmsworksSDK

### Constructor

```c
#include "core/api.h"

ThesmsworksSDK* client = thesmsworks_sdk_new(options);
```

Create a new SDK client instance. `options` is a `voxgig_value*` map
(`NULL` for none).

**Parameters (`options` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Test Constructor

#### `ThesmsworksSDK* test_sdk(voxgig_value* testopts, voxgig_value* sdkopts)`

Create a test client with mock features active. Both arguments may be
`NULL`.

```c
ThesmsworksSDK* client = test_sdk(NULL, NULL);
```


### Entity Accessors

#### `Entity* thesmsworks_batch(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `Batch` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_batch_message(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `BatchMessage` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_credit(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `Credit` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_flash(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `Flash` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_message(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `Message` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_one_time_password(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `OneTimePassword` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_schedule(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `Schedule` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_swagger(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `Swagger` entity instance. Pass `NULL` for no initial
options.

#### `Entity* thesmsworks_util(ThesmsworksSDK* client, voxgig_value* entopts)`

Create a new `Util` entity instance. Pass `NULL` for no initial
options.

#### `voxgig_value* sdk_direct(ThesmsworksSDK* client, voxgig_value* fetchargs, PNError** err)`

Make a direct HTTP request to any API endpoint. Returns a result map with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never sets `*err` for a non-2xx response — branch on
`getp(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `voxgig_value* sdk_prepare(ThesmsworksSDK* client, voxgig_value* fetchargs, PNError** err)`

Prepare a fetch definition without sending. Returns the fetchdef and sets
`*err` on failure.


---

## Batch

```c
Entity* batch = thesmsworks_batch(client, NULL);
```

### Operations

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* batch = thesmsworks_batch(client, NULL);
voxgig_value* result = batch->vt->load(batch, cmap(1, "id", v_str("batch_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Batch` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## BatchMessage

```c
Entity* batch_message = thesmsworks_batch_message(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `char*` | Yes |  |
| `deliveryreporturl` | `char*` | No |  |
| `destination` | `voxgig_value* (list)` | Yes |  |
| `schedule` | `char*` | No |  |
| `sender` | `char*` | Yes |  |
| `tag` | `char*` | No |  |
| `ttl` | `double` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* batch_message = thesmsworks_batch_message(client, NULL);
voxgig_value* result = batch_message->vt->create(batch_message, cmap(3,
    "content", v_str("example_content"),  // char*
    "destination", v_list(),  // voxgig_value* (list)
    "sender", v_str("example_sender"))  // char*
, NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* batch_message = thesmsworks_batch_message(client, NULL);
voxgig_value* result = batch_message->vt->remove(batch_message, cmap(1, "batchid", v_str("batchid")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `BatchMessage` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Credit

```c
Entity* credit = thesmsworks_credit(client, NULL);
```

### Operations

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* credit = thesmsworks_credit(client, NULL);
voxgig_value* result = credit->vt->load(credit, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Credit` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Flash

```c
Entity* flash = thesmsworks_flash(client, NULL);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Flash` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Message

```c
Entity* message = thesmsworks_message(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `char*` | Yes |  |
| `credit` | `double` | No |  |
| `deliveryreporturl` | `char*` | No |  |
| `destination` | `char*` | Yes |  |
| `from` | `char*` | No |  |
| `keyword` | `char*` | No |  |
| `limit` | `double` | No |  |
| `metadata` | `voxgig_value* (map)` | No |  |
| `responseemail` | `voxgig_value* (list)` | No |  |
| `schedule` | `char*` | No |  |
| `sender` | `char*` | Yes |  |
| `skip` | `double` | No |  |
| `status` | `char*` | No |  |
| `tag` | `char*` | No |  |
| `to` | `char*` | No |  |
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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* message = thesmsworks_message(client, NULL);
voxgig_value* result = message->vt->create(message, cmap(3,
    "content", v_str("example_content"),  // char*
    "destination", v_str("example_destination"),  // char*
    "sender", v_str("example_sender"))  // char*
, NULL, &err);
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* message = thesmsworks_message(client, NULL);
voxgig_value* result = message->vt->load(message, cmap(1, "id", v_str("message_id")), NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* message = thesmsworks_message(client, NULL);
voxgig_value* result = message->vt->remove(message, cmap(1, "id", v_str("message_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Message` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## OneTimePassword

```c
Entity* one_time_password = thesmsworks_one_time_password(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `char*` | No |  |
| `length` | `voxgig_value* (map)` | No |  |
| `metadata` | `voxgig_value* (map)` | No |  |
| `passcode` | `char*` | No |  |
| `sender` | `char*` | No |  |
| `template` | `char*` | No |  |
| `validity` | `double` | No |  |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* one_time_password = thesmsworks_one_time_password(client, NULL);
voxgig_value* result = one_time_password->vt->create(one_time_password, NULL, NULL, &err);
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* one_time_password = thesmsworks_one_time_password(client, NULL);
voxgig_value* result = one_time_password->vt->load(one_time_password, cmap(1, "messageid", v_str("messageid")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `OneTimePassword` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Schedule

```c
Entity* schedule = thesmsworks_schedule(client, NULL);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Schedule` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Swagger

```c
Entity* swagger = thesmsworks_swagger(client, NULL);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Swagger` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Util

```c
Entity* util = thesmsworks_util(client, NULL);
```

### Operations

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* util = thesmsworks_util(client, NULL);
voxgig_value* result = util->vt->load(util, cmap(1, "errorcode", v_str("errorcode")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Util` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```c
ThesmsworksSDK* client = thesmsworks_sdk_new(cmap(1,
    "feature", cmap(1,
        "test", cmap(1, "active", v_bool(true)))
));
```

