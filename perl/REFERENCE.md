# Thesmsworks Perl SDK Reference

Complete API reference for the Thesmsworks Perl SDK.


## ThesmsworksSDK

### Constructor

```perl
use lib 'lib';
use ThesmsworksSDK;

my $client = ThesmsworksSDK->new($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `hashref` | SDK configuration options. |
| `$options->{apikey}` | `string` | API key for authentication. |
| `$options->{base}` | `string` | Base URL for API requests. |
| `$options->{prefix}` | `string` | URL prefix appended after base. |
| `$options->{suffix}` | `string` | URL suffix appended after path. |
| `$options->{headers}` | `hashref` | Custom headers for all requests. |
| `$options->{feature}` | `hashref` | Feature configuration. |
| `$options->{system}` | `hashref` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK->test($testopts, $sdkopts)`

Create a test client with mock features active. Both arguments may be `undef`.

```perl
my $client = ThesmsworksSDK->test();
```


### Instance Methods

#### `Batch($data)`

Create a new `Batch` entity instance. Pass `undef` for no initial data.

#### `BatchMessage($data)`

Create a new `BatchMessage` entity instance. Pass `undef` for no initial data.

#### `Credit($data)`

Create a new `Credit` entity instance. Pass `undef` for no initial data.

#### `Flash($data)`

Create a new `Flash` entity instance. Pass `undef` for no initial data.

#### `Message($data)`

Create a new `Message` entity instance. Pass `undef` for no initial data.

#### `OneTimePassword($data)`

Create a new `OneTimePassword` entity instance. Pass `undef` for no initial data.

#### `Schedule($data)`

Create a new `Schedule` entity instance. Pass `undef` for no initial data.

#### `Swagger($data)`

Create a new `Swagger` entity instance. Pass `undef` for no initial data.

#### `Util($data)`

Create a new `Util` entity instance. Pass `undef` for no initial data.

#### `options_map() -> hashref`

Return a deep copy of the current SDK options.

#### `get_utility() -> utility`

Return a copy of the SDK utility object.

#### `direct($fetchargs) -> hashref`

Make a direct HTTP request to any API endpoint. Returns a result `hashref` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never dies — branch on `$result->{ok}`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs->{path}` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs->{method}` | `string` | HTTP method (default: `'GET'`). |
| `$fetchargs->{params}` | `hashref` | Path parameter values. |
| `$fetchargs->{query}` | `hashref` | Query string parameters. |
| `$fetchargs->{headers}` | `hashref` | Request headers (merged with defaults). |
| `$fetchargs->{body}` | `any` | Request body (hashrefs are JSON-serialized). |

**Returns:** `hashref`

#### `prepare($fetchargs) -> hashref`

Prepare a fetch definition without sending. Returns the `fetchdef` and dies on error.


---

## Batch entity

```perl
my $batch = $client->Batch;
```

### Operations

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Batch->load({ 'id' => 'batch_id' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Batch` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## BatchMessage entity

```perl
my $batch_message = $client->BatchMessage;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `boolean` | No |  |
| `content` | `string` | Yes |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `arrayref` | Yes |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `tag` | `string` | No |  |
| `ttl` | `number` | No |  |
| `validity` | `number` | No |  |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->BatchMessage->create({
    'content' => 'example_content',  # string
    'destination' => [],  # arrayref
    'sender' => 'example_sender',  # string
});
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->BatchMessage->remove({ 'batchid' => 'batchid' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `BatchMessage` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Credit entity

```perl
my $credit = $client->Credit;
```

### Operations

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Credit->load();
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Credit` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Flash entity

```perl
my $flash = $client->Flash;
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Flash` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Message entity

```perl
my $message = $client->Message;
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
| `metadata` | `hashref` | No |  |
| `responseemail` | `arrayref` | No |  |
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Message->create({
    'content' => 'example_content',  # string
    'destination' => 'example_destination',  # string
    'sender' => 'example_sender',  # string
});
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Message->load({ 'id' => 'message_id' });
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Message->remove({ 'id' => 'message_id' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Message` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## OneTimePassword entity

```perl
my $one_time_password = $client->OneTimePassword;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `string` | No |  |
| `length` | `hashref` | No |  |
| `metadata` | `hashref` | No |  |
| `passcode` | `string` | No |  |
| `sender` | `string` | No |  |
| `template` | `string` | No |  |
| `validity` | `number` | No |  |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->OneTimePassword->create({
});
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->OneTimePassword->load({ 'messageid' => 'messageid' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `OneTimePassword` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Schedule entity

```perl
my $schedule = $client->Schedule;
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Schedule` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Swagger entity

```perl
my $swagger = $client->Swagger;
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Swagger` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Util entity

```perl
my $util = $client->Util;
```

### Operations

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Util->load({ 'errorcode' => 'errorcode' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Util` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```perl
my $client = ThesmsworksSDK->new({
    'feature' => {
        'test' => { 'active' => 1 },
    },
});
```

