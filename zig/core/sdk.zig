// ThesmsworksSDK client (generated — mirrors the go/rust Main fragment).

const std = @import("std");
const vs = @import("voxgig-struct");
const h = @import("helpers.zig");
const errmod = @import("error.zig");
const types = @import("types.zig");
const ctxmod = @import("context.zig");
const utility_mod = @import("utility.zig");
const spec_mod = @import("spec.zig");
const config = @import("config.zig");

const Value = h.Value;
const E = errmod.E;
const Context = ctxmod.Context;
const CtxSpec = ctxmod.CtxSpec;
const Utility = utility_mod.Utility;
const Feature = types.Feature;
const OpResult = types.OpResult;
const Spec = spec_mod.Spec;

pub const ThesmsworksSDK = struct {
    mode: []const u8 = "live",
    options: Value = .{ .null = {} },
    utility: *Utility,
    features: std.ArrayList(Feature),
    rootctx: ?*Context = null,

    pub fn new(options: Value) *ThesmsworksSDK {
        const sdk = h.A().create(ThesmsworksSDK) catch unreachable;
        sdk.* = .{
            .mode = "live",
            .options = h.vnull(),
            .utility = Utility.new(),
            .features = std.ArrayList(Feature).init(h.A()),
            .rootctx = null,
        };

        const cfg = config.make_config();

        const rootctx = sdk.utility.make_context(CtxSpec{
            .client = sdk,
            .utility = sdk.utility,
            .config = cfg,
            .options = options,
            .shared = h.omap(),
        }, null);

        const opts = sdk.utility.make_options(rootctx);
        sdk.options = opts;

        if (h.veq(h.getpath(&.{ "feature", "test", "active" }, opts), h.vbool(true))) {
            sdk.mode = "test";
        }

        rootctx.options = opts;
        sdk.rootctx = rootctx;

        // Add features in the resolved order (make_options puts an explicit
        // list order first, else defaults to test-first). Ordering matters:
        // the `test` feature installs the base mock transport and the
        // transport features (retry/cache/netsim/proxy/ratelimit) wrap
        // whatever is current, so `test` must be added before them to sit at
        // the base of the transport wrapper chain.
        const feature_opts = h.to_map(h.getp(opts, "feature"));
        const feature_order = h.getpath(&.{ "__derived__", "featureorder" }, opts);
        if (feature_opts == .object and feature_order == .array) {
            for (feature_order.array.data.items) |fname_v| {
                if (fname_v != .string) continue;
                const fname = fname_v.string;
                const fopts = h.getp(feature_opts, fname);
                if (fopts == .object) {
                    if (h.get_bool(fopts, "active") orelse false) {
                        sdk.utility.feature_add(rootctx, config.make_feature(fname));
                    }
                }
            }
        }

        // Initialize features.
        var snap = std.ArrayList(Feature).init(h.A());
        for (sdk.features.items) |f| snap.append(f) catch {};
        for (snap.items) |f| sdk.utility.feature_init(rootctx, f);

        sdk.utility.feature_hook(rootctx, "PostConstruct");

        return sdk;
    }

    pub fn options_map(self: *ThesmsworksSDK) Value {
        return h.clone(self.options);
    }

    pub fn get_utility(self: *ThesmsworksSDK) *Utility {
        return Utility.copy(self.utility);
    }

    pub fn get_root_ctx(self: *ThesmsworksSDK) *Context {
        return self.rootctx orelse unreachable;
    }

    pub fn prepare(self: *ThesmsworksSDK, fetchargs_in: Value) E!Value {
        const utility = self.utility;

        const fetchargs: Value = switch (fetchargs_in) {
            .object => fetchargs_in,
            else => h.omap(),
        };

        const ctrl: Value = switch (h.to_map(h.getp(fetchargs, "ctrl"))) {
            .object => h.to_map(h.getp(fetchargs, "ctrl")),
            else => h.omap(),
        };

        const ctx = utility.make_context(CtxSpec{
            .opname = "prepare",
            .ctrl = ctrl,
        }, self.get_root_ctx());

        const options = self.options;

        const path = h.get_str(fetchargs, "path") orelse "";
        const method: []const u8 = blk: {
            const m = h.get_str(fetchargs, "method");
            break :blk if (m) |mm| (if (mm.len == 0) "GET" else mm) else "GET";
        };

        const params: Value = switch (h.to_map(h.getp(fetchargs, "params"))) {
            .object => h.to_map(h.getp(fetchargs, "params")),
            else => h.omap(),
        };
        const query: Value = switch (h.to_map(h.getp(fetchargs, "query"))) {
            .object => h.to_map(h.getp(fetchargs, "query")),
            else => h.omap(),
        };

        const headers = utility.prepare_headers(ctx);

        const specmap = h.jo(&.{
            .{ "base", h.getp(options, "base") },
            .{ "prefix", h.getp(options, "prefix") },
            .{ "suffix", h.getp(options, "suffix") },
            .{ "path", h.vstr(path) },
            .{ "method", h.vstr(method) },
            .{ "params", params },
            .{ "query", query },
            .{ "headers", headers },
            .{ "body", h.getp(fetchargs, "body") },
            .{ "step", h.vstr("start") },
        });
        const spec = Spec.make(specmap);
        ctx.spec = spec;

        // Merge user-provided headers.
        if (h.getp(fetchargs, "headers") == .object) {
            const uh = h.getp(fetchargs, "headers");
            var it = uh.object.iterator();
            while (it.next()) |kv| h.setp(spec.headers, kv.key_ptr.*, kv.value_ptr.*);
        }

        _ = try utility.prepare_auth(ctx);

        return utility.make_fetch_def(ctx);
    }

    pub fn direct(self: *ThesmsworksSDK, fetchargs_in: Value) Value {
        const utility = self.utility;

        const fetchdef = self.prepare(fetchargs_in) catch {
            return h.jo(&.{
                .{ "ok", h.vbool(false) },
                .{ "err", h.vstr(if (self.rootctx.?.pending_err) |e| e.msg else "prepare failed") },
            });
        };

        const fetchargs: Value = switch (fetchargs_in) {
            .object => fetchargs_in,
            else => h.omap(),
        };
        const ctrl: Value = switch (h.to_map(h.getp(fetchargs, "ctrl"))) {
            .object => h.to_map(h.getp(fetchargs, "ctrl")),
            else => h.omap(),
        };

        const ctx = utility.make_context(CtxSpec{
            .opname = "direct",
            .ctrl = ctrl,
        }, self.get_root_ctx());

        const url = h.get_str(fetchdef, "url") orelse "";
        const fetched = utility.fetch(ctx, url, fetchdef) catch {
            return h.jo(&.{
                .{ "ok", h.vbool(false) },
                .{ "err", h.vstr(if (ctx.pending_err) |e| e.msg else "fetch failed") },
            });
        };

        if (h.is_noval(fetched)) {
            return h.jo(&.{
                .{ "ok", h.vbool(false) },
                .{ "err", h.vstr("response: undefined") },
            });
        }

        if (fetched == .object) {
            const status = h.to_int(h.getp(fetched, "status"));
            const headers = h.getp(fetched, "headers");

            const content_length: []const u8 = switch (h.getp(headers, "content-length")) {
                .string => |s| s,
                .integer => |n| std.fmt.allocPrint(h.A(), "{d}", .{n}) catch "",
                else => "",
            };
            const no_body = status == 204 or status == 304 or std.mem.eql(u8, content_length, "0");

            const json_data: Value = if (no_body) h.vnull() else blk: {
                const jf = h.getp(fetched, "json");
                break :blk if (jf == .function) h.call_json(jf) else h.vnull();
            };

            return h.jo(&.{
                .{ "ok", h.vbool(200 <= status and status < 300) },
                .{ "status", h.vnum(status) },
                .{ "headers", headers },
                .{ "data", json_data },
            });
        }

        return h.jo(&.{
            .{ "ok", h.vbool(false) },
            .{ "err", h.vstr("invalid response type") },
        });
    }


    /// Batch entity bound to this client.
    pub fn batch(self: *@This(), entopts: Value) *@import("../entity/batch.zig").BatchEntity {
        return @import("../entity/batch.zig").BatchEntity.new(self, entopts);
    }

    /// BatchMessage entity bound to this client.
    pub fn batch_message(self: *@This(), entopts: Value) *@import("../entity/batch_message.zig").BatchMessageEntity {
        return @import("../entity/batch_message.zig").BatchMessageEntity.new(self, entopts);
    }

    /// Credit entity bound to this client.
    pub fn credit(self: *@This(), entopts: Value) *@import("../entity/credit.zig").CreditEntity {
        return @import("../entity/credit.zig").CreditEntity.new(self, entopts);
    }

    /// Flash entity bound to this client.
    pub fn flash(self: *@This(), entopts: Value) *@import("../entity/flash.zig").FlashEntity {
        return @import("../entity/flash.zig").FlashEntity.new(self, entopts);
    }

    /// Message entity bound to this client.
    pub fn message(self: *@This(), entopts: Value) *@import("../entity/message.zig").MessageEntity {
        return @import("../entity/message.zig").MessageEntity.new(self, entopts);
    }

    /// OneTimePassword entity bound to this client.
    pub fn one_time_password(self: *@This(), entopts: Value) *@import("../entity/one_time_password.zig").OneTimePasswordEntity {
        return @import("../entity/one_time_password.zig").OneTimePasswordEntity.new(self, entopts);
    }

    /// Schedule entity bound to this client.
    pub fn schedule(self: *@This(), entopts: Value) *@import("../entity/schedule.zig").ScheduleEntity {
        return @import("../entity/schedule.zig").ScheduleEntity.new(self, entopts);
    }

    /// Swagger entity bound to this client.
    pub fn swagger(self: *@This(), entopts: Value) *@import("../entity/swagger.zig").SwaggerEntity {
        return @import("../entity/swagger.zig").SwaggerEntity.new(self, entopts);
    }

    /// Util entity bound to this client.
    pub fn util(self: *@This(), entopts: Value) *@import("../entity/util.zig").UtilEntity {
        return @import("../entity/util.zig").UtilEntity.new(self, entopts);
    }

};

pub fn test_sdk(testopts_in: Value, sdkopts_in: Value) *ThesmsworksSDK {
    const sdkopts: Value = switch (sdkopts_in) {
        .object => h.clone(sdkopts_in),
        else => h.omap(),
    };

    const testopts: Value = switch (testopts_in) {
        .object => h.clone(testopts_in),
        else => h.omap(),
    };
    h.setp(testopts, "active", h.vbool(true));

    // set_path mutates `sdkopts` in place; keep the ROOT (gotcha #8 — do not
    // rebind to the return of setpath).
    h.setpath(sdkopts, &.{ "feature", "test" }, testopts);

    const sdk = ThesmsworksSDK.new(sdkopts);
    sdk.mode = "test";

    return sdk;
}
