# Thesmsworks Zig SDK



The Zig SDK for the Thesmsworks API — an entity-oriented client following idiomatic Zig conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.batch(h.vnull())` — each
carrying a small, uniform set of operations (`load`, `create`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
Zig has no central package registry, so this package is distributed as a
git tag (`zig/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/thesmsworks-sdk/tags)). Add it to
your `build.zig.zon` dependencies, or build from a source checkout:

```bash
cd zig && zig build
```

To depend on it from another project, add the tagged archive to
`build.zig.zon`:

```zig
.dependencies = .{
    .sdk = .{
        .url = "<repo-url>/archive/refs/tags/zig/vX.Y.Z.tar.gz",
        // .hash = "...", // filled in by `zig fetch`
    },
},
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```zig
const std = @import("std");
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.ThesmsworksSDK.new(h.jo(&.{
    .{ "apikey", h.vstr(std.posix.getenv("THESMSWORKS_APIKEY") orelse "") },
}));
```

### 3. Load a batch

`load()`'s `.ok` carries the entity; `asEntity().data(null)` reads its
record.

```zig
switch (client.batch(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("example_id") }}), h.vnull())) {
    .ok => |batch| std.debug.print("{s}\n", .{h.stringify(batch.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const batch = await client.Batch().load({ id: "example_id" })
  console.log(batch.data())
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
result envelope. Branch on `ok`; on failure `status` holds the HTTP status
(for error responses) and `err` holds the error:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (!result.ok) {
  console.error('request failed:', result.status, result.err)
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```zig
const result = client.direct(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("GET") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
}));

if (h.get_bool(result, "ok") orelse false) {
    std.debug.print("{d}\n", .{h.to_int(h.getp(result, "status"))}); // 200
    std.debug.print("{s}\n", .{h.stringify(h.getp(result, "data"))}); // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    std.debug.print("{s}\n", .{h.get_str(result, "err") orelse ""});
}
```

### Prepare a request without sending it

```zig
// prepare() returns the fetch definition (an error union — use `catch`/`try`).
const fetchdef = client.prepare(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("DELETE") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
})) catch unreachable;

std.debug.print("{s}\n", .{h.get_str(fetchdef, "url") orelse ""});
std.debug.print("{s}\n", .{h.get_str(fetchdef, "method") orelse ""});
std.debug.print("{s}\n", .{h.stringify(h.getp(fetchdef, "headers"))});
```

### Use test mode

Create a mock client for unit testing — no server required:

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());

// Entity ops return a result union — .ok carries the entity, .err the error.
switch (client.batch(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("test01") }}), h.vnull())) {
    .ok => |batch| std.debug.print("{s}\n", .{h.stringify(batch.asEntity().data(null))}), // the mock record
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Point at a different server

Override the base URL to reach a local or staging server:

```zig
const client = sdk.ThesmsworksSDK.new(h.jo(&.{
    .{ "base", h.vstr("http://localhost:8080") },
}));
```

### Run live tests

Create a `.env.local` file at the project root:

```
THESMSWORKS_TEST_LIVE=TRUE
THESMSWORKS_APIKEY=<your-key>
```

Then run:

```bash
cd zig && zig build test
```


## Reference

### ThesmsworksSDK

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.ThesmsworksSDK.new(options);
```

Creates a new SDK client. `options` is a `Value` map (`h.vnull()` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom fetcher). |

### test_sdk

```zig
const client = sdk.test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`h.vnull()`.

### ThesmsworksSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() Value` | Deep copy of the current SDK options. |
| `get_utility` | `() *Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs: Value) E!Value` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs: Value) Value` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `batch` | `(entopts: Value) *BatchEntity` | Create a Batch entity instance. |
| `batch_message` | `(entopts: Value) *BatchMessageEntity` | Create a BatchMessage entity instance. |
| `credit` | `(entopts: Value) *CreditEntity` | Create a Credit entity instance. |
| `message` | `(entopts: Value) *MessageEntity` | Create a Message entity instance. |
| `message_message` | `(entopts: Value) *MessageMessageEntity` | Create a MessageMessage entity instance. |
| `message_schedule` | `(entopts: Value) *MessageScheduleEntity` | Create a MessageSchedule entity instance. |
| `one_time_password` | `(entopts: Value) *OneTimePasswordEntity` | Create an OneTimePassword entity instance. |
| `schedule` | `(entopts: Value) *ScheduleEntity` | Create a Schedule entity instance. |
| `util` | `(entopts: Value) *UtilEntity` | Create an Util entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch: Value, ctrl: Value) EntResult` | Load a single entity by match criteria. |
| `create` | `(reqdata: Value, ctrl: Value) EntResult` | Create a new entity. |
| `remove` | `(reqmatch: Value, ctrl: Value) EntResult` | Remove an entity, which is returned marked as deleted. |
| `stream` | `(action: []const u8, args: Value, callopts: Value) StreamResult` | Run an op through the pipeline: `.ok` with its result items, or `.err` with the error that failed it. |
| `data` | `(args: ?Value) Value` | Get entity data (pass a map to set). |
| `matchv` | `(args: ?Value) Value` | Get entity match criteria (pass a map to set). |
| `get_name` | `() []const u8` | Return the entity name. |

### Result shape

Entity operations return a result union — `switch` on it: `.ok` carries
the entity (`EntResult`), or for `list` a slice of entities, one per record
(`EntListResult`), and `asEntity().data(null)` reads an entity's record;
`.err` carries the branded error pointer.

The `direct()` escape hatch returns a result `Value` map directly (no
error union) — even on a non-2xx response — that you branch on via
`h.get_bool(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error message.

### Entities

#### Batch

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Load.

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

Operations: Create.

API path: `/batch/any`

#### Credit

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/credits/balance`

#### Message

| Field | Description |
| --- | --- |

Operations: Create.

API path: `/messages/failed`

#### MessageMessage

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

Operations: Create, Load, Remove.

API path: `/messages`

#### MessageSchedule

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Load, Remove.

API path: `/messages/schedule`

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

Operations: Create, Load.

API path: `/otp/send`

#### Schedule

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Remove.

API path: `/batches/schedule/{batchid}`

#### Util

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/utils/errors/{errorcode}`



## Entities


### Batch

Create an instance: `const batch = client.batch(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.batch(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("batch_id") }}), h.vnull())) {
    .ok => |batch| std.debug.print("{s}\n", .{h.stringify(batch.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```


### BatchMessage

Create an instance: `const batch_message = client.batch_message(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `ai` | `bool` | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `[]const u8` | Message to send to the recipient |
| `deliveryreporturl` | `[]const u8` | The url to which we should POST delivery reports to for this message. |
| `destinations` | `Value (array)` | Telephone numbers of each of the recipients |
| `schedule` | `[]const u8` | Date-time at which to send the batch. |
| `sender` | `[]const u8` | The sender of the message. |
| `tag` | `[]const u8` | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `f64` | The number of minutes before the delivery report is deleted. |
| `validity` | `f64` | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

#### Example: Create

```zig
switch (client.batch_message(h.vnull()).create(h.jo(&.{
    .{ "content", h.vstr("example_content") }, // []const u8
    .{ "destinations", h.olist() }, // Value (array)
    .{ "sender", h.vstr("example_sender") }, // []const u8
}), h.vnull())) {
    .ok => |batch_message| std.debug.print("{s}\n", .{h.stringify(batch_message.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Credit

Create an instance: `const credit = client.credit(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Example: Load

```zig
switch (client.credit(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |credit| std.debug.print("{s}\n", .{h.stringify(credit.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```


### Message

Create an instance: `const message = client.message(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.


### MessageMessage

Create an instance: `const message_message = client.message_message(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `credits` | `f64` | The number of credits used on the message. |
| `destination` | `[]const u8` | The phone number of the recipient. |
| `from` | `[]const u8` | The date-time from which you would like matching messages |
| `id` | `[]const u8` |  |
| `keyword` | `[]const u8` | The keyword used in the inbound message |
| `limit` | `f64` | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Value (object)` | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `sender` | `[]const u8` | The sender of the message (this can be the configured sender name for an outbound message or the senders phone number for an inbound message). |
| `skip` | `f64` | The number of results you would like to ignore before returning messages. |
| `status` | `[]const u8` | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `to` | `[]const u8` | The date-time to which you would like matching messages |
| `unread` | `bool` | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |

#### Example: Load

```zig
switch (client.message_message(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("message_message_id") }}), h.vnull())) {
    .ok => |message_message| std.debug.print("{s}\n", .{h.stringify(message_message.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.message_message(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |message_message| std.debug.print("{s}\n", .{h.stringify(message_message.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### MessageSchedule

Create an instance: `const message_schedule = client.message_schedule(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.message_schedule(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("message_schedule_id") }}), h.vnull())) {
    .ok => |message_schedule| std.debug.print("{s}\n", .{h.stringify(message_schedule.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```


### OneTimePassword

Create an instance: `const one_time_password = client.one_time_password(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `destination` | `[]const u8` | The phone number of the recipient. |
| `length` | `Value (object)` | The length of the generated passcode. |
| `metadata` | `Value (object)` | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `[]const u8` | A passcode you supply for use in the message template. |
| `sender` | `[]const u8` | The sender of the message. |
| `template` | `[]const u8` | A template to use as the content for the message. |
| `validity` | `f64` | The length of time in seconds for which the generated passcode should be valid. |

#### Example: Load

```zig
switch (client.one_time_password(h.vnull()).load(h.jo(&.{.{ "messageid", h.vstr("messageid") }}), h.vnull())) {
    .ok => |one_time_password| std.debug.print("{s}\n", .{h.stringify(one_time_password.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.one_time_password(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |one_time_password| std.debug.print("{s}\n", .{h.stringify(one_time_password.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Schedule

Create an instance: `const schedule = client.schedule(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `[]const u8` |  |


### Util

Create an instance: `const util = client.util(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Example: Load

```zig
switch (client.util(h.vnull()).load(h.jo(&.{.{ "errorcode", h.vstr("errorcode") }}), h.vnull())) {
    .ok => |util| std.debug.print("{s}\n", .{h.stringify(util.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

## Features

This SDK ships 20 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`audit`](#audit) | Audit trail |
| [`cache`](#cache) | Response cache |
| [`clienttrack`](#clienttrack) | Client tracking |
| [`cost`](#cost) | Cost tracking |
| [`debug`](#debug) | Debug capture |
| [`idempotency`](#idempotency) | Idempotency |
| [`log`](#log) | Logging |
| [`metrics`](#metrics) | Metrics |
| [`netsim`](#netsim) | Network simulation |
| [`paging`](#paging) | Paging |
| [`proxy`](#proxy) | Proxy |
| [`ratelimit`](#ratelimit) | Rate limiting |
| [`rbac`](#rbac) | Access control |
| [`retry`](#retry) | Retry |
| [`secrets`](#secrets) | Secrets |
| [`streaming`](#streaming) | Streaming |
| [`telemetry`](#telemetry) | Telemetry |
| [`test`](#test) | Test transport |
| [`timeout`](#timeout) | Timeout |
| [`validate`](#validate) | Validation |

> **Order matters for `cache`, `cost`, `netsim`, `proxy`, `ratelimit`, `retry`, `secrets`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### audit

Audit trail.

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

Set `feature.audit.active` to enable it, then override any of the options above.

### cache

Response cache.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `256` |
| `methods` | `['GET']` |
| `ttl` | `5000` |

Set `feature.cache.active` to enable it, then override any of the options above.

`cache` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### clienttrack

Client tracking.

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

Set `feature.clienttrack.active` to enable it, then override any of the options above.

### cost

Cost tracking.

| Option | Default |
|---|---|
| `active` | `false` |
| `budget` | `0` |
| `currency` | `'USD'` |
| `header` | `''` |
| `onBudget` | `'warn'` |
| `path` | `''` |
| `perUnit` | `0` |
| `rates` | `{}` |
| `unit` | `0` |

Set `feature.cost.active` to enable it, then override any of the options above.

`cost` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### debug

Debug capture.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

Set `feature.debug.active` to enable it, then override any of the options above.

### idempotency

Idempotency.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### log

Logging.

| Option | Default |
|---|---|
| `active` | `true` |

Set `feature.log.active` to enable it, then override any of the options above.

### metrics

Metrics.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### netsim

Network simulation.

| Option | Default |
|---|---|
| `active` | `false` |
| `errorTimes` | `0` |
| `failEvery` | `0` |
| `failRate` | `0` |
| `failStatus` | `503` |
| `failTimes` | `0` |
| `latency` | `0` |
| `offline` | `false` |
| `rateLimitTimes` | `0` |
| `retryAfter` | `0` |
| `seed` | `1` |

Set `feature.netsim.active` to enable it, then override any of the options above.

`netsim` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### paging

Paging.

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

### proxy

Proxy.

| Option | Default |
|---|---|
| `active` | `false` |
| `fromEnv` | `false` |
| `noProxy` | `[]` |
| `url` | `''` |

Set `feature.proxy.active` to enable it, then override any of the options above.

`proxy` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### ratelimit

Rate limiting.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### rbac

Access control.

| Option | Default |
|---|---|
| `active` | `false` |
| `deny` | `false` |
| `permissions` | `[]` |
| `rules` | `{}` |

Set `feature.rbac.active` to enable it, then override any of the options above.

### retry

Retry.

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

### secrets

Secrets.

| Option | Default |
|---|---|
| `active` | `false` |
| `cache` | `true` |
| `exchange` | `{active: false, method: 'POST', path: 'auth/token', refresh: '', request: 'refresh_token', response: 'access_token', retries: 1, statuses: [401]}` |
| `name` | `'apikey'` |
| `providers` | `[]` |

Set `feature.secrets.active` to enable it, then override any of the options above.

`secrets` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### streaming

Streaming.

| Option | Default |
|---|---|
| `active` | `false` |
| `chunkDelay` | `0` |
| `chunkSize` | `0` |

Set `feature.streaming.active` to enable it, then override any of the options above.

### telemetry

Telemetry.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.telemetry.active` to enable it, then override any of the options above.

### test

Test transport.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Timeout.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### validate

Validation.

| Option | Default |
|---|---|
| `active` | `false` |
| `mode` | `'throw'` |
| `request` | `true` |
| `response` | `false` |
| `strict` | `false` |

Set `feature.validate.active` to enable it, then override any of the options above.


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

- **AuditFeature**: Audit trail
- **CacheFeature**: Response cache
- **ClienttrackFeature**: Client tracking
- **CostFeature**: Cost tracking
- **DebugFeature**: Debug capture
- **IdempotencyFeature**: Idempotency
- **LogFeature**: Logging
- **MetricsFeature**: Metrics
- **NetsimFeature**: Network simulation
- **PagingFeature**: Paging
- **ProxyFeature**: Proxy
- **RatelimitFeature**: Rate limiting
- **RbacFeature**: Access control
- **RetryFeature**: Retry
- **SecretsFeature**: Secrets
- **StreamingFeature**: Streaming
- **TelemetryFeature**: Telemetry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout
- **ValidateFeature**: Validation

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as `Value`

The Zig SDK uses a single dynamic `Value` type throughout rather than a
typed struct per entity. `Value` is the vendored voxgig struct port's
`JsonValue` (a JSON-shaped tagged union: `.string`, `.integer`,
`.float`, `.bool`, `.array`, `.object`, `.null`). This mirrors the
dynamic nature of the API and keeps the SDK flexible — no code generation is
needed when the API schema changes.

Build request maps with the `h.jo` / `h.ja` helpers and read fields back
with `h.getp` (or the typed `h.get_str` / `h.get_bool` / `h.to_int`
accessors); use `h.to_map` to safely coerce a value to a map.

### Module structure

```
zig/
├── root.zig                     -- Module root (re-exports the public surface)
├── build.zig                    -- Build + test wiring
├── core/                        -- Pipeline types, config, client (sdk.zig)
├── entity/                      -- Per-entity clients (one file each)
├── feature/                     -- Built-in features (base, test, log)
├── utility/                     -- Utilities + the vendored voxgig struct port
└── test/                        -- Test suites
```

The public API is re-exported from `root.zig`, so `@import("sdk")` reaches
the SDK client, `Value`, and the `h` (helpers) namespace directly. Import
entity or utility modules only when needed.

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
