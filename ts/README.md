# Thesmsworks TypeScript SDK



The TypeScript SDK for the Thesmsworks API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Batch()` — each with a small set of operations (`load`, `create`, `remove`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/thesmsworks-sdk/releases](https://github.com/voxgig-sdk/thesmsworks-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { ThesmsworksSDK } from '@voxgig-sdk/thesmsworks'

const client = new ThesmsworksSDK({
  apikey: process.env.THESMSWORKS_APIKEY,
})
```

### 3. Load an onetimepassword

OneTimePassword is nested under messageid, so provide the `messageid`.
`load()` returns the entity directly and throws on failure:

```ts
try {
  const onetimepassword = await client.OneTimePassword().load({
    messageid: 'example_messageid',
  })
  console.log(onetimepassword)
} catch (err) {
  console.error('load failed:', err)
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

```ts
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

```ts
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

```ts
const client = ThesmsworksSDK.test()

const batch = await client.Batch().load({ id: 'test01' })
// batch is a bare entity populated with mock response data
console.log(batch)
```

You can also use the instance method:

```ts
const client = new ThesmsworksSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Batch()

// First call runs the operation and stores its result
await entity.load({ id: 'example' })

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
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
cd ts && npm test
```


## Reference

### ThesmsworksSDK

#### Constructor

```ts
new ThesmsworksSDK(options?: {
  apikey?: string
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
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
- `remove` resolves to `void`.

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

### Entities

#### Batch

| Field | Description |
| --- | --- |

Operations: load.

API path: `/batch/{batchid}`

#### BatchMessage

| Field | Description |
| --- | --- |
| `ai` |  |
| `content` |  |
| `deliveryreporturl` |  |
| `destination` |  |
| `schedule` |  |
| `sender` |  |
| `tag` |  |
| `ttl` |  |
| `validity` |  |

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
| `ai` |  |
| `content` |  |
| `credit` |  |
| `deliveryreporturl` |  |
| `destination` |  |
| `from` |  |
| `keyword` |  |
| `limit` |  |
| `metadata` |  |
| `responseemail` |  |
| `schedule` |  |
| `sender` |  |
| `skip` |  |
| `status` |  |
| `tag` |  |
| `to` |  |
| `ttl` |  |
| `unread` |  |
| `validity` |  |

Operations: create, load, remove.

API path: `/message/flash`

#### OneTimePassword

| Field | Description |
| --- | --- |
| `destination` |  |
| `length` |  |
| `metadata` |  |
| `passcode` |  |
| `sender` |  |
| `template` |  |
| `validity` |  |

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
| `ai` | `boolean` |  |
| `content` | `string` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `any[]` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `tag` | `string` |  |
| `ttl` | `number` |  |
| `validity` | `number` |  |

#### Example: Create

```ts
const batch_message = await client.BatchMessage().create({
  content: /* string */,
  destination: /* any[] */,
  sender: /* string */,
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
| `ai` | `boolean` |  |
| `content` | `string` |  |
| `credit` | `number` |  |
| `deliveryreporturl` | `string` |  |
| `destination` | `string` |  |
| `from` | `string` |  |
| `keyword` | `string` |  |
| `limit` | `number` |  |
| `metadata` | `Record<string, any>` |  |
| `responseemail` | `any[]` |  |
| `schedule` | `string` |  |
| `sender` | `string` |  |
| `skip` | `number` |  |
| `status` | `string` |  |
| `tag` | `string` |  |
| `to` | `string` |  |
| `ttl` | `number` |  |
| `unread` | `boolean` |  |
| `validity` | `number` |  |

#### Example: Load

```ts
const message = await client.Message().load({ id: 'message_id' })
```

#### Example: Create

```ts
const message = await client.Message().create({
  content: /* string */,
  destination: /* string */,
  sender: /* string */,
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
| `destination` | `string` |  |
| `length` | `Record<string, any>` |  |
| `metadata` | `Record<string, any>` |  |
| `passcode` | `string` |  |
| `sender` | `string` |  |
| `template` | `string` |  |
| `validity` | `number` |  |

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

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
thesmsworks/
├── src/
│   ├── ThesmsworksSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { ThesmsworksSDK } from '@voxgig-sdk/thesmsworks'
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
