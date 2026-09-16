# Thesmsworks JavaScript SDK



The JavaScript SDK for the Thesmsworks API — an entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Batch()` — each with a small set of operations (`load`, `create`, `remove`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```js
npm install thesmsworks
```
## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.


### Create a Client

```js
const { ThesmsworksSDK } = require('@voxgig-sdk/thesmsworks-js')

const client = new ThesmsworksSDK({
  apikey: process.env.THESMSWORKS_APIKEY,
})
```

### Load a Batch

```js
const batch = await client.Batch().load({ id: 'batch_id' })
console.log(batch)
```

### Direct API Access

Use `client.direct()` to call any API endpoint directly:

```js
const result = await client.direct({
  path: '/custom/endpoint/{id}',
  method: 'GET',
  params: { id: 'abc123' },
})

if (result.ok) {
  console.log(result.data)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const batch = await client.Batch().load({ id: "example_id" })
  console.log(batch)
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```js
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result instanceof Error) {
  throw result
}
if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```js
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```js
const client = ThesmsworksSDK.test()

const batch = await client.Batch().load({ id: 'test01' })
// batch is the entity, populated with mock response data
// — call batch.data() for the record itself
console.log(batch)
```

You can also use the instance method:

```js
const client = new ThesmsworksSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```js
const entity = client.Batch()

// First call runs the operation and stores its result
await entity.load({ id: 'example' })

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data.id)
```

### Add custom middleware

Pass features via the `extend` option:

```js
const logger = {
  hooks: {
    PreRequest: (ctx) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new ThesmsworksSDK({
  apikey: '...',
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd js && npm test
```


## Reference

### ThesmsworksSDK

#### Constructor

```js
new ThesmsworksSDK(options?)
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Batch(data?)` | `BatchEntity` | Create a Batch entity instance. |
| `BatchMessage(data?)` | `BatchMessageEntity` | Create a BatchMessage entity instance. |
| `Credit(data?)` | `CreditEntity` | Create a Credit entity instance. |
| `Flash(data?)` | `FlashEntity` | Create a Flash entity instance. |
| `Message(data?)` | `MessageEntity` | Create a Message entity instance. |
| `OneTimePassword(data?)` | `OneTimePasswordEntity` | Create an OneTimePassword entity instance. |
| `Schedule(data?)` | `ScheduleEntity` | Create a Schedule entity instance. |
| `Swagger(data?)` | `SwaggerEntity` | Create a Swagger entity instance. |
| `Util(data?)` | `UtilEntity` | Create an Util entity instance. |
| `tester(testopts?, sdkopts?)` | `ThesmsworksSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `ThesmsworksSDK.test(testopts?, sdkopts?)` | `ThesmsworksSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Entity>` | Load a single entity by match criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Entity>` | Create a new entity. |
| `remove` | `remove(reqmatch?, ctrl?): Promise<void>` | Remove an entity. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): ThesmsworksSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `load` and `create` resolve to a single entity object.
- `remove` resolves to `undefined`.

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```js
{
  ok: true,
  status: 200,
  headers: {},
  data: {}
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```js
{
  url: 'string',
  method: 'string',
  headers: {},
  body: undefined
}
```

### Entities

#### Batch

| Field | Description |
| --- | --- |
| `id` |  |

Operations: load.

API path: `/batch/{batchid}`

#### BatchMessage

| Field | Description |
| --- | --- |
| `ai` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | Message to send to the recipient |
| `deliveryreporturl` | The url to which we should POST delivery reports to for this message. |
| `destinations` | Telephone numbers of each of the recipients |
| `schedule` | Date-time at which to send the batch. |
| `sender` | The sender of the message. |
| `tag` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | The number of minutes before the delivery report is deleted. |
| `validity` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

Operations: create, remove.

API path: `/batch/any`

#### Credit

| Field | Description |
| --- | --- |

Operations: load.

API path: `/credits/balance`

#### Flash

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Message

| Field | Description |
| --- | --- |
| `credits` | The number of credits used on the message. |
| `destination` | The phone number of the recipient. |
| `from` | The date-time from which you would like matching messages |
| `id` |  |
| `keyword` | The keyword used in the inbound message |
| `limit` | The maximum number of messages that you would like returned in this call. |
| `metadata` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | The number of results you would like to ignore before returning messages. |
| `status` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | The date-time to which you would like matching messages |
| `unread` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

Operations: create, load, remove.

API path: `/message/flash`

#### OneTimePassword

| Field | Description |
| --- | --- |
| `destination` | The phone number of the recipient. |
| `length` | The length of the generated passcode. |
| `metadata` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | A passcode you supply for use in the message template. |
| `sender` | The sender of the message. |
| `template` | A template to use as the content for the message. |
| `validity` | The length of time in seconds for which the generated passcode should be valid. |

Operations: create, load.

API path: `/otp/send`

#### Schedule

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Swagger

| Field | Description |
| --- | --- |

Operations: .

API path: ``

#### Util

| Field | Description |
| --- | --- |

Operations: load.

API path: `/utils/errors/{errorcode}`



## Entities


### Batch

Create an instance: `const batch = client.Batch()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |

#### Example: Load

```ts
const batch = await client.Batch().load({ id: 'batch_id' })
```


### BatchMessage

Create an instance: `const batch_message = client.BatchMessage()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `boolean` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `string` | Message to send to the recipient |
| `deliveryreporturl` | `string` | The url to which we should POST delivery reports to for this message. |
| `destinations` | `Array` | Telephone numbers of each of the recipients |
| `schedule` | `string` | Date-time at which to send the batch. |
| `sender` | `string` | The sender of the message. |
| `tag` | `string` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `number` | The number of minutes before the delivery report is deleted. |
| `validity` | `number` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Create

```ts
const batch_message = await client.BatchMessage().create({
  content: 'example_content',
  destinations: [],
  sender: 'example_sender',
})
```


### Credit

Create an instance: `const credit = client.Credit()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const credit = await client.Credit().load()
```


### Flash

Create an instance: `const flash = client.Flash()`


### Message

Create an instance: `const message = client.Message()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `credits` | `number` | The number of credits used on the message. |
| `destination` | `string` | The phone number of the recipient. |
| `from` | `string` | The date-time from which you would like matching messages |
| `id` | `string` |  |
| `keyword` | `string` | The keyword used in the inbound message |
| `limit` | `number` | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Object` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `string` | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `number` | The number of results you would like to ignore before returning messages. |
| `status` | `string` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `string` | The date-time to which you would like matching messages |
| `unread` | `boolean` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

#### Example: Load

```ts
const message = await client.Message().load({ id: 'message_id' })
```

#### Example: Create

```ts
const message = await client.Message().create({
})
```


### OneTimePassword

Create an instance: `const one_time_password = client.OneTimePassword()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `string` | The phone number of the recipient. |
| `length` | `Object` | The length of the generated passcode. |
| `metadata` | `Object` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `string` | A passcode you supply for use in the message template. |
| `sender` | `string` | The sender of the message. |
| `template` | `string` | A template to use as the content for the message. |
| `validity` | `number` | The length of time in seconds for which the generated passcode should be valid. |

#### Example: Load

```ts
const one_time_password = await client.OneTimePassword().load({ messageid: 'messageid' })
```

#### Example: Create

```ts
const one_time_password = await client.OneTimePassword().create({
})
```


### Schedule

Create an instance: `const schedule = client.Schedule()`


### Swagger

Create an instance: `const swagger = client.Swagger()`


### Util

Create an instance: `const util = client.Util()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const util = await client.Util().load({ errorcode: 'errorcode' })
```

## Features

This SDK ships 8 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`debug`](#debug) | Request/response capture ring buffer for debugging |
| [`idempotency`](#idempotency) | Idempotency keys for safe retries of mutating operations |
| [`metrics`](#metrics) | Statistics capture: per-operation counters and latency |
| [`paging`](#paging) | Pagination signals for list operations |
| [`ratelimit`](#ratelimit) | Client-side rate limiting via a token bucket |
| [`retry`](#retry) | Automatic retry of transient failures with exponential backoff |
| [`test`](#test) | In-memory mock transport for testing without a live server |
| [`timeout`](#timeout) | Per-request timeout with transport abort |

> **Order matters for `ratelimit`, `retry`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### debug

Request/response capture ring buffer for debugging.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

Set `feature.debug.active` to enable it, then override any of the options above.

### idempotency

Idempotency keys for safe retries of mutating operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### metrics

Statistics capture: per-operation counters and latency.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### paging

Pagination signals for list operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Set `feature.paging.active` to enable it, then override any of the options above.

### ratelimit

Client-side rate limiting via a token bucket.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### retry

Automatic retry of transient failures with exponential backoff.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Per-request timeout with transport abort.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **DebugFeature**: Request/response capture ring buffer for debugging
- **IdempotencyFeature**: Idempotency keys for safe retries of mutating operations
- **MetricsFeature**: Statistics capture: per-operation counters and latency
- **PagingFeature**: Pagination signals for list operations
- **RatelimitFeature**: Client-side rate limiting via a token bucket
- **RetryFeature**: Automatic retry of transient failures with exponential backoff
- **TestFeature**: In-memory mock transport for testing without a live server
- **TimeoutFeature**: Per-request timeout with transport abort

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
thesmsworks/
├── src/
│   ├── ThesmsworksSDK.js        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
└── test/                   # Test suites
```

Import the SDK from the package root:

```js
const { ThesmsworksSDK } = require('@voxgig-sdk/thesmsworks-js')
```

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const batch = client.Batch()
await batch.load({ id: "example_id" })

// batch.data() now returns the batch data from the last `load`
// batch.match() returns { id: "example_id" }
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
