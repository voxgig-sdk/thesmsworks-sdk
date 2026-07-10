# Thesmsworks PHP SDK Reference

Complete API reference for the Thesmsworks PHP SDK.


## ThesmsworksSDK

### Constructor

```php
require_once __DIR__ . '/thesmsworks_sdk.php';

$client = new ThesmsworksSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["apikey"]` | `string` | API key for authentication. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `ThesmsworksSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = ThesmsworksSDK::test();
```


### Instance Methods

#### `Batch($data = null)`

Create a new `BatchEntity` instance. Pass `null` for no initial data.

#### `BatchMessage($data = null)`

Create a new `BatchMessageEntity` instance. Pass `null` for no initial data.

#### `Credit($data = null)`

Create a new `CreditEntity` instance. Pass `null` for no initial data.

#### `Flash($data = null)`

Create a new `FlashEntity` instance. Pass `null` for no initial data.

#### `Message($data = null)`

Create a new `MessageEntity` instance. Pass `null` for no initial data.

#### `OneTimePassword($data = null)`

Create a new `OneTimePasswordEntity` instance. Pass `null` for no initial data.

#### `Schedule($data = null)`

Create a new `ScheduleEntity` instance. Pass `null` for no initial data.

#### `Swagger($data = null)`

Create a new `SwaggerEntity` instance. Pass `null` for no initial data.

#### `Util($data = null)`

Create a new `UtilEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): ThesmsworksUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## BatchEntity

```php
$batch = $client->Batch();
```

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Batch()->load(["id" => "batch_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): BatchEntity`

Create a new `BatchEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## BatchMessageEntity

```php
$batch_message = $client->BatchMessage();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `array` | Yes |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `tag` | `string` | No |  |
| `ttl` | `float` | No |  |
| `validity` | `float` | No |  |

### Operations

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->BatchMessage()->create([
  "content" => null, // string
  "destination" => null, // array
  "sender" => null, // string
]);
```

#### `remove(array $reqmatch, ?array $ctrl = null): mixed`

Remove the entity matching the given criteria. Throws on error.

```php
$result = $client->BatchMessage()->remove(["batchid" => "batchid"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): BatchMessageEntity`

Create a new `BatchMessageEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CreditEntity

```php
$credit = $client->Credit();
```

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Credit()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CreditEntity`

Create a new `CreditEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## FlashEntity

```php
$flash = $client->Flash();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): FlashEntity`

Create a new `FlashEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## MessageEntity

```php
$message = $client->Message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No |  |
| `content` | `string` | Yes |  |
| `credit` | `float` | No |  |
| `deliveryreporturl` | `string` | No |  |
| `destination` | `string` | Yes |  |
| `from` | `string` | No |  |
| `keyword` | `string` | No |  |
| `limit` | `float` | No |  |
| `metadata` | `array` | No |  |
| `responseemail` | `array` | No |  |
| `schedule` | `string` | No |  |
| `sender` | `string` | Yes |  |
| `skip` | `float` | No |  |
| `status` | `string` | No |  |
| `tag` | `string` | No |  |
| `to` | `string` | No |  |
| `ttl` | `float` | No |  |
| `unread` | `bool` | No |  |
| `validity` | `float` | No |  |

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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->Message()->create([
  "content" => null, // string
  "destination" => null, // string
  "sender" => null, // string
]);
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Message()->load(["id" => "message_id"]);
```

#### `remove(array $reqmatch, ?array $ctrl = null): mixed`

Remove the entity matching the given criteria. Throws on error.

```php
$result = $client->Message()->remove(["id" => "message_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): MessageEntity`

Create a new `MessageEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## OneTimePasswordEntity

```php
$one_time_password = $client->OneTimePassword();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `string` | No |  |
| `length` | `array` | No |  |
| `metadata` | `array` | No |  |
| `passcode` | `string` | No |  |
| `sender` | `string` | No |  |
| `template` | `string` | No |  |
| `validity` | `float` | No |  |

### Operations

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->OneTimePassword()->create([
]);
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->OneTimePassword()->load(["messageid" => "messageid"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): OneTimePasswordEntity`

Create a new `OneTimePasswordEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ScheduleEntity

```php
$schedule = $client->Schedule();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ScheduleEntity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## SwaggerEntity

```php
$swagger = $client->Swagger();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): SwaggerEntity`

Create a new `SwaggerEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## UtilEntity

```php
$util = $client->Util();
```

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Util()->load(["errorcode" => "errorcode"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): UtilEntity`

Create a new `UtilEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new ThesmsworksSDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

