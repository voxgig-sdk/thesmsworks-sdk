# Thesmsworks Zig SDK Reference

Complete API reference for the Thesmsworks Zig SDK.


## ThesmsworksSDK

### Constructor

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.ThesmsworksSDK.new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`h.vnull()` for none).

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

#### `test_sdk(testopts: Value, sdkopts: Value) *ThesmsworksSDK`

Create a test client with mock features active. Both arguments may be
`h.vnull()`.

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());
```


### Instance Methods

#### `batch(entopts: Value) *BatchEntity`

Create a new `BatchEntity` instance. Pass `h.vnull()` for no
initial options.

#### `batch_message(entopts: Value) *BatchMessageEntity`

Create a new `BatchMessageEntity` instance. Pass `h.vnull()` for no
initial options.

#### `credit(entopts: Value) *CreditEntity`

Create a new `CreditEntity` instance. Pass `h.vnull()` for no
initial options.

#### `flash(entopts: Value) *FlashEntity`

Create a new `FlashEntity` instance. Pass `h.vnull()` for no
initial options.

#### `message(entopts: Value) *MessageEntity`

Create a new `MessageEntity` instance. Pass `h.vnull()` for no
initial options.

#### `one_time_password(entopts: Value) *OneTimePasswordEntity`

Create a new `OneTimePasswordEntity` instance. Pass `h.vnull()` for no
initial options.

#### `schedule(entopts: Value) *ScheduleEntity`

Create a new `ScheduleEntity` instance. Pass `h.vnull()` for no
initial options.

#### `swagger(entopts: Value) *SwaggerEntity`

Create a new `SwaggerEntity` instance. Pass `h.vnull()` for no
initial options.

#### `util(entopts: Value) *UtilEntity`

Create a new `UtilEntity` instance. Pass `h.vnull()` for no
initial options.

#### `options_map() Value`

Return a deep copy of the current SDK options.

#### `get_utility() *Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value`
map with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch returns a map even on a non-2xx response — branch on
`h.get_bool(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) E!Value`

Prepare a fetch definition without sending. Returns the fetchdef (use
`catch`/`try` to handle the error union).


---

## BatchEntity

```zig
const batch = client.batch(h.vnull());
```

### Operations

#### `load(reqmatch: Value, ctrl: Value) OpResult`

Load a single entity matching the given criteria. `.ok` carries the entity data, `.err` the branded error.

```zig
switch (client.batch(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("batch_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## BatchMessageEntity

```zig
const batch_message = client.batch_message(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `[]const u8` | Yes | Message to send to the recipient |
| `deliveryreporturl` | `[]const u8` | No | The url to which we should POST delivery reports to for this message. |
| `destinations` | `Value (array)` | Yes | Telephone numbers of each of the recipients |
| `schedule` | `[]const u8` | No | Date-time at which to send the batch. |
| `sender` | `[]const u8` | Yes | The sender of the message. |
| `tag` | `[]const u8` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `ttl` | `f64` | No | The number of minutes before the delivery report is deleted. |
| `validity` | `f64` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Operations

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

```zig
switch (client.batch_message(h.vnull()).create(h.jo(&.{
    .{ "content", h.vstr("example_content") }, // []const u8
    .{ "destinations", h.olist() }, // Value (array)
    .{ "sender", h.vstr("example_sender") }, // []const u8
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) OpResult`

Remove the entity matching the given criteria. `.err` on failure.

```zig
switch (client.batch_message(h.vnull()).remove(h.jo(&.{.{ "batchid", h.vstr("batchid") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## CreditEntity

```zig
const credit = client.credit(h.vnull());
```

### Operations

#### `load(reqmatch: Value, ctrl: Value) OpResult`

Load a single entity matching the given criteria. `.ok` carries the entity data, `.err` the branded error.

```zig
switch (client.credit(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## FlashEntity

```zig
const flash = client.flash(h.vnull());
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## MessageEntity

```zig
const message = client.message(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ai` | `bool` | No | Used to determine whether The SMS Works AI Optimiser should be used in the event that the message is just longer than the 1 or 2 credit boundary. |
| `content` | `[]const u8` | Yes | Message to send to the recipient. |
| `credits` | `f64` | No | The number of credits used on the message. |
| `deliveryreporturl` | `[]const u8` | No | The url to which we should POST delivery reports to for this message. |
| `destination` | `[]const u8` | Yes | Telephone number of the recipient |
| `from` | `[]const u8` | No | The date-time from which you would like matching messages |
| `keyword` | `[]const u8` | No | The keyword used in the inbound message |
| `limit` | `f64` | No | The maximum number of messages that you would like returned in this call. |
| `metadata` | `Value (object)` | No | An array of objects containing metadata key/value pairs that have been saved on messages. |
| `responseemail` | `Value (array)` | No | An optional list of email addresses to forward responses to this specific message to. |
| `schedule` | `[]const u8` | No | Date at which to send the message. |
| `sender` | `[]const u8` | Yes | The sender of the message. |
| `skip` | `f64` | No | The number of results you would like to ignore before returning messages. |
| `status` | `[]const u8` | No | The status of the messages you would like returned (either 'SENT', 'DELIVERED', 'EXPIRED', 'UNDELIVERABLE', 'REJECTED' or 'INCOMING') |
| `tag` | `[]const u8` | No | An identifying label for the message, which you can use to filter and report on messages you've sent later. |
| `to` | `[]const u8` | No | The date-time to which you would like matching messages |
| `ttl` | `f64` | No | The optional number of minutes before the delivery report is deleted. |
| `unread` | `bool` | No | In queries for incoming messages ('status' is 'INCOMING'), specify whether you explicitly want unread messages (true) or read messages (false). |
| `validity` | `f64` | No | The optional number of minutes to attempt delivery before the message is marked as EXPIRED. |

### Field Usage by Operation

| Field | load | create | remove |
| --- | --- | --- | --- |
| `ai` | - | - | - |
| `content` | - | - | - |
| `credits` | - | - | - |
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

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

```zig
switch (client.message(h.vnull()).create(h.jo(&.{
    .{ "content", h.vstr("example_content") }, // []const u8
    .{ "destination", h.vstr("example_destination") }, // []const u8
    .{ "sender", h.vstr("example_sender") }, // []const u8
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) OpResult`

Load a single entity matching the given criteria. `.ok` carries the entity data, `.err` the branded error.

```zig
switch (client.message(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("message_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) OpResult`

Remove the entity matching the given criteria. `.err` on failure.

```zig
switch (client.message(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("message_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## OneTimePasswordEntity

```zig
const one_time_password = client.one_time_password(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `destination` | `[]const u8` | No | The phone number of the recipient. |
| `length` | `Value (object)` | No | The length of the generated passcode. |
| `metadata` | `Value (object)` | No | A JSON object of no longer than 1024 bytes, containing as many parameters as you wish, to store data for use in your application. |
| `passcode` | `[]const u8` | No | A passcode you supply for use in the message template. |
| `sender` | `[]const u8` | No | The sender of the message. |
| `template` | `[]const u8` | No | A template to use as the content for the message. |
| `validity` | `f64` | No | The length of time in seconds for which the generated passcode should be valid. |

### Operations

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

```zig
switch (client.one_time_password(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) OpResult`

Load a single entity matching the given criteria. `.ok` carries the entity data, `.err` the branded error.

```zig
switch (client.one_time_password(h.vnull()).load(h.jo(&.{.{ "messageid", h.vstr("messageid") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## ScheduleEntity

```zig
const schedule = client.schedule(h.vnull());
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## SwaggerEntity

```zig
const swagger = client.swagger(h.vnull());
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## UtilEntity

```zig
const util = client.util(h.vnull());
```

### Operations

#### `load(reqmatch: Value, ctrl: Value) OpResult`

Load a single entity matching the given criteria. `.ok` carries the entity data, `.err` the branded error.

```zig
switch (client.util(h.vnull()).load(h.jo(&.{.{ "errorcode", h.vstr("errorcode") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```zig
const client = sdk.ThesmsworksSDK.new(h.jo(&.{
    .{ "feature", h.jo(&.{
        .{ "test", h.jo(&.{.{ "active", h.vbool(true) }}) },
    }) },
}));
```

