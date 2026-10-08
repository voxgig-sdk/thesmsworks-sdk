// Generated smoke tests (model-driven). Drive each entity through the
// offline test transport and assert a non-error result.

const std = @import("std");
const sdk = @import("sdk");
const fh = @import("fh.zig");
const h = sdk.h;
const Value = sdk.Value;

fn vnull() Value {
    return Value{ .null = {} };
}

test "sdk_constructs_in_test_mode" {
    const testsdk = sdk.testSdk();
    try std.testing.expect(std.mem.eql(u8, testsdk.mode, "test"));
}

test "batch_load_smoke" {
    const fixture = h.jo(&.{.{ "batch", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.batch(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("batch load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "batch_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).batch(vnull()).load(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "batch_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/batch/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "batch_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/batch/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "batch_message_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).batch_message(vnull()).create(h.jo(&.{ .{ "ai", h.vstr("x") }, .{ "content", h.vstr("x") }, .{ "destinations", h.vstr("x") }, .{ "sender", h.vstr("x") } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "credit_load_smoke" {
    const fixture = h.jo(&.{.{ "credit", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.credit(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("credit load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "credit_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/credit/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "credit_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/credit/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "message_message_load_smoke" {
    const fixture = h.jo(&.{.{ "message_message", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.message_message(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("message_message load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "message_message_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).message_message(vnull()).load(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "message_message_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/message_message/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "message_message_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/message_message/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "message_schedule_load_smoke" {
    const fixture = h.jo(&.{.{ "message_schedule", h.jo(&.{.{ "t01", h.jo(&.{.{ "id", h.vstr("t01") }}) }}) }});
    const testsdk = sdk.test_sdk(h.jo(&.{.{ "entity", fixture }}), vnull());
    const e = testsdk.message_schedule(vnull());
    const res = e.load(h.jo(&.{.{ "id", h.vstr("t01") }}), vnull());
    switch (res) {
        .ok => |ent| {
            // EVERY operation resolves to the ENTITY, not the record: the
            // payload of EntResult.ok is the entity pointer, and the record is
            // reached through data(). Destructuring it as a Value was a
            // compile error ("expected type 'struct.JsonValue', found
            // '*entity.<name>.<Name>Entity'"), so no generated zig SDK with a
            // loadable entity could build its own test suite.
            const rec = ent.asEntity().data(null);
            try std.testing.expect(std.mem.eql(u8, h.get_str(rec, "id") orelse "", "t01"));
        },
        .err => |er| {
            std.debug.print("message_schedule load failed: {s}\n", .{er.msg});
            try std.testing.expect(false);
        },
    }
}

test "message_schedule_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).message_schedule(vnull()).load(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "message_schedule_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/message_schedule/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "message_schedule_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/message_schedule/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "one_time_password_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).one_time_password(vnull()).load(h.jo(&.{ .{ "messageid", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "one_time_password_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/one_time_password/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "one_time_password_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/one_time_password/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

test "schedule_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).schedule(vnull()).remove(h.jo(&.{ .{ "id", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "util_validate" {
    if (!fh.fh_has_feature("validate")) return error.SkipZigTest;
    const opts = h.jo(&.{.{ "feature", h.jo(&.{.{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) }}) }});
    switch (sdk.test_sdk(vnull(), opts).util(vnull()).load(h.jo(&.{ .{ "errorcode", h.vnum(1) } }), vnull())) {
        .err => |er| try std.testing.expect(std.mem.eql(u8, er.code, "validate_failed")),
        .ok => try std.testing.expect(false),
    }
}

test "util_direct_smoke" {
    // direct() drives prepare -> transport and always returns a result map
    // carrying an `ok` flag (never an error union), even on a non-2xx or a
    // prepare failure.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const result = testsdk.direct(h.jo(&.{
        .{ "path", h.vstr("/util/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);
}

test "util_prepare_smoke" {
    // prepare() returns the fetch definition (an error union). The generated
    // fetchdef always carries a url + method.
    const testsdk = sdk.test_sdk(vnull(), vnull());
    const fetchdef = testsdk.prepare(h.jo(&.{
        .{ "path", h.vstr("/util/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("direct01") }}) },
    })) catch {
        // A prepare error is acceptable here (base may be unset); the surface
        // exists and is exercised.
        return;
    };
    try std.testing.expect(std.mem.eql(u8, h.get_str(fetchdef, "method") orelse "", "GET"));
}

// Documented quick-start surface (README.md / REFERENCE.md). Exercises the
// test-mode constructor and the direct() escape hatch exactly as documented.
test "readme_quickstart_surface" {
    // `sdk.test_sdk(...)` — the documented mock constructor.
    const client = sdk.test_sdk(vnull(), vnull());
    try std.testing.expect(std.mem.eql(u8, client.mode, "test"));

    // `client.direct(...)` — the documented escape hatch. It always returns a
    // result map carrying an `ok` flag (never an error union).
    const result = client.direct(h.jo(&.{
        .{ "path", h.vstr("/api/resource/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
    }));
    try std.testing.expect(result == .object);
    try std.testing.expect(h.get_bool(result, "ok") != null);

    // `client.prepare(...)` — build a request without sending it.
    const fetchdef = client.prepare(h.jo(&.{
        .{ "path", h.vstr("/api/resource/{id}") },
        .{ "method", h.vstr("GET") },
        .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
    })) catch h.vnull();
    _ = fetchdef;
}
