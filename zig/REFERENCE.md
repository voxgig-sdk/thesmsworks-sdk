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
| `ai` | `bool` | No |  |
| `content` | `[]const u8` | Yes |  |
| `deliveryreporturl` | `[]const u8` | No |  |
| `destination` | `Value (array)` | Yes |  |
| `schedule` | `[]const u8` | No |  |
| `sender` | `[]const u8` | Yes |  |
| `tag` | `[]const u8` | No |  |
| `ttl` | `f64` | No |  |
| `validity` | `f64` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

```zig
switch (client.batch_message(h.vnull()).create(h.jo(&.{
    .{ "content", h.vstr("example_content") }, // []const u8
    .{ "destination", h.olist() }, // Value (array)
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
| `ai` | `bool` | No |  |
| `content` | `[]const u8` | Yes |  |
| `credit` | `f64` | No |  |
| `deliveryreporturl` | `[]const u8` | No |  |
| `destination` | `[]const u8` | Yes |  |
| `from` | `[]const u8` | No |  |
| `keyword` | `[]const u8` | No |  |
| `limit` | `f64` | No |  |
| `metadata` | `Value (object)` | No |  |
| `responseemail` | `Value (array)` | No |  |
| `schedule` | `[]const u8` | No |  |
| `sender` | `[]const u8` | Yes |  |
| `skip` | `f64` | No |  |
| `status` | `[]const u8` | No |  |
| `tag` | `[]const u8` | No |  |
| `to` | `[]const u8` | No |  |
| `ttl` | `f64` | No |  |
| `unread` | `bool` | No |  |
| `validity` | `f64` | No |  |

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
| `destination` | `[]const u8` | No |  |
| `length` | `Value (object)` | No |  |
| `metadata` | `Value (object)` | No |  |
| `passcode` | `[]const u8` | No |  |
| `sender` | `[]const u8` | No |  |
| `template` | `[]const u8` | No |  |
| `validity` | `f64` | No |  |

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

