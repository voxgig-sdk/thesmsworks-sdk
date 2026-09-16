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

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

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
| `ai` | `boolean` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `string` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `arrayref` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `string` | No | Date-time at which to send the batch. |
| `sender` | `string` | Yes | The sender of the message. |
| `tag` | `string` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `number` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `number` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->BatchMessage->create({
    'content' => 'example_content',  # string
    'destinations' => [],  # arrayref
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
| `credits` | `number` | No | The number of credits used on the message. |
| `destination` | `string` | No | The phone number of the recipient. |
| `from` | `string` | No | The date-time from which you would like matching messages |
| `id` | `string` | No |  |
| `keyword` | `string` | No | The keyword used in the inbound message |
| `limit` | `number` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `hashref` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `string` | No | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `number` | No | The number of results you would like to ignore before returning messages. |
| `status` | `string` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `string` | No | The date-time to which you would like matching messages |
| `unread` | `boolean` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Message->create({
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
| `destination` | `string` | No | The phone number of the recipient. |
| `length` | `hashref` | No | The length of the generated passcode. |
| `metadata` | `hashref` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `string` | No | A passcode you supply for use in the message template. |
| `sender` | `string` | No | The sender of the message. |
| `template` | `string` | No | A template to use as the content for the message. |
| `validity` | `number` | No | The length of time in seconds for which the generated passcode should be valid. |

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
| `debug` | 0.0.1 | Request/response capture ring buffer for debugging |
| `idempotency` | 0.0.1 | Idempotency keys for safe retries of mutating operations |
| `metrics` | 0.0.1 | Statistics capture: per-operation counters and latency |
| `paging` | 0.0.1 | Pagination signals for list operations |
| `ratelimit` | 0.0.1 | Client-side rate limiting via a token bucket |
| `retry` | 0.0.1 | Automatic retry of transient failures with exponential backoff |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |
| `timeout` | 0.0.1 | Per-request timeout with transport abort |


Features are activated via the `feature` option:

```perl
my $client = ThesmsworksSDK->new({
    'feature' => {
        'debug' => { 'active' => 1 },
        'idempotency' => { 'active' => 1 },
        'metrics' => { 'active' => 1 },
        'paging' => { 'active' => 1 },
        'ratelimit' => { 'active' => 1 },
        'retry' => { 'active' => 1 },
        'test' => { 'active' => 1 },
        'timeout' => { 'active' => 1 },
    },
});
```


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### Ordering

`ratelimit`, `retry`, `timeout` wrap the transport. Each
wraps whatever is already installed, so **activation order is nesting order**:
a feature activated later sits OUTSIDE one activated earlier, and sees the call
first.

That decides behaviour, not just sequence: a feature that short-circuits the
call, such as a cache serving a hit, stops every feature nested inside it from
ever seeing that call.

`debug`, `idempotency`, `metrics`, `paging`, `test` attach to pipeline hooks
rather than the transport, so their order does not affect what they observe.

#### `debug`

Request/response capture ring buffer for debugging.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

| Option | Type |
|---|---|
| `now` | function |
| `onEntry` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.debug.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `idempotency`

Idempotency keys for safe retries of mutating operations.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

| Option | Type |
|---|---|
| `keygen` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.idempotency.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `metrics`

Statistics capture: per-operation counters and latency.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `now` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.metrics.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `paging`

Pagination signals for list operations.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

| Option | Type |
|---|---|
| `limit` | number |
| `ops` | list |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.paging.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `ratelimit`

Client-side rate limiting via a token bucket.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

| Option | Type |
|---|---|
| `now` | function |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.ratelimit.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `retry`

Automatic retry of transient failures with exponential backoff.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

| Option | Type |
|---|---|
| `jitter` | boolean |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.retry.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `test`

In-memory mock transport for testing without a live server.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `entity` | map |
| `net` | map |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

#### `timeout`

Per-request timeout with transport abort.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

| Option | Type |
|---|---|
| `clearTimer` | function |
| `setTimer` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.timeout.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

