// Thesmsworks SDK client.
//
// SDK TYPES ARE MODULE-QUALIFIED IN THIS FILE (`ThesmsworksSdk.VMap`, not
// `VMap`), and only in this file. MainEntity_swift emits one accessor PER
// ENTITY into this class body, named after the entity - `Utility()`,
// `Spec()`, `Value()` for an API with entities of those names - and inside
// a class body a METHOD of that name shadows the TYPE for every unqualified
// use: `utility = Utility()` then reads as a call to the accessor, and
// `-> Utility` as a return type that does not exist. The entity TYPE is
// already renamed on such a collision (swiftSafeTypeName), but the accessor
// keeps the entity's own name, which is the public API. Qualifying by
// module - the generated module is <Name>Sdk, so `ThesmsworksSdk.` lands as
// `<Name>Sdk.` - is the one spelling a method cannot shadow. The shared
// fixture's `utility` entity is what found this; every other swift file is
// outside this class and unaffected.

import Foundation

public final class ThesmsworksSDK {
  public var mode = "live"
  private var options: ThesmsworksSdk.VMap = ThesmsworksSdk.VMap()
  private let utility: ThesmsworksSdk.Utility
  public var features: [BaseFeature] = []
  private var rootctx: ThesmsworksSdk.Context!

  public init(_ optionsIn: ThesmsworksSdk.VMap? = nil) {
    utility = ThesmsworksSdk.Utility()

    // The process-wide config (sdkgen rung L2): read-only on the request path,
    // so every client shares one rather than rebuilding it.
    let config = SdkConfig.sharedConfig()

    var ctxmap: [String: Any?] = [
      "client": self,
      "utility": utility,
      "config": config,
      "shared": ThesmsworksSdk.VMap(),
    ]
    if let o = optionsIn { ctxmap["options"] = o }

    rootctx = utility.makeContext(ctxmap, nil)

    options = utility.makeOptions(rootctx)

    if gpath(options, "feature", "test", "active") == .bool(true) {
      mode = "test"
    }

    rootctx.options = options

    // Add features in the resolved order (makeOptions puts an explicit list
    // order first, else defaults to test-first). Ordering matters: the `test`
    // feature installs the base mock transport and the transport features
    // (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
    // must be added before them to sit at the base of the chain.
    let featureOpts = gp(options, "feature").asMap ?? ThesmsworksSdk.VMap()
    if let featureOrder = gpath(options, "__derived__", "featureorder").asList {
      for fnameVal in featureOrder.items {
        let fname = fnameVal.asString ?? ""
        if fname != "", let fopts = gp(featureOpts, fname).asMap,
          fopts.entries["active"]?.asBool == true {
          utility.featureAdd(rootctx, SdkConfig.makeFeature(fname))
        }
      }
    }

    // Add extension features.
    if let extList = gp(options, "extend").asList {
      for f in extList.items {
        if let feat = f.asNative as? BaseFeature {
          utility.featureAdd(rootctx, feat)
        }
      }
    }

    // Initialize features.
    for f in features {
      utility.featureInit(rootctx, f)
    }

    utility.featureHook(rootctx, "PostConstruct")
  }

  public func optionsMap() -> ThesmsworksSdk.VMap {
    return clone(.map(options)).asMap ?? ThesmsworksSdk.VMap()
  }

  public func getUtility() -> ThesmsworksSdk.Utility {
    return ThesmsworksSdk.Utility.copy(utility)
  }

  public func getRootCtx() -> ThesmsworksSdk.Context {
    return rootctx
  }

  public func prepare(_ fetchargsIn: ThesmsworksSdk.VMap?) throws -> ThesmsworksSdk.VMap {
    let utility = self.utility

    let fetchargs = fetchargsIn ?? ThesmsworksSdk.VMap()

    let ctrl = gp(fetchargs, "ctrl").asMap ?? ThesmsworksSdk.VMap()

    let ctx = utility.makeContext(["opname": "prepare", "ctrl": ctrl], rootctx)

    let options = self.options

    let path = gp(fetchargs, "path").asString ?? ""
    var method = gp(fetchargs, "method").asString ?? ""
    if method == "" { method = "GET" }

    let pathParams = gp(fetchargs, "params").asMap ?? ThesmsworksSdk.VMap()
    let query = gp(fetchargs, "query").asMap ?? ThesmsworksSdk.VMap()

    let headers = utility.prepareHeaders(ctx)

    let basev = gp(options, "base").asString ?? ""
    let prefix = gp(options, "prefix").asString ?? ""
    let suffix = gp(options, "suffix").asString ?? ""

    let specmap = ThesmsworksSdk.VMap()
    specmap.entries["base"] = .string(basev)
    specmap.entries["prefix"] = .string(prefix)
    specmap.entries["suffix"] = .string(suffix)
    specmap.entries["path"] = .string(path)
    specmap.entries["method"] = .string(method)
    specmap.entries["params"] = .map(pathParams)
    specmap.entries["query"] = .map(query)
    specmap.entries["headers"] = .map(headers)
    specmap.entries["body"] = gp(fetchargs, "body")
    specmap.entries["step"] = .string("start")
    ctx.spec = ThesmsworksSdk.Spec(specmap)

    // Merge user-provided headers.
    if let uhm = gp(fetchargs, "headers").asMap {
      for (k, v) in uhm.entries {
        ctx.spec!.headers.entries[k] = v
      }
    }

    _ = try utility.prepareAuth(ctx)

    return try utility.makeFetchDef(ctx)
  }

  // Raw endpoint access is operator-controllable, like every entity op.
  // Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
  // either one reaches the same endpoint.
  public func direct(_ fetchargsIn: ThesmsworksSdk.VMap?) -> ThesmsworksSdk.VMap {
    if !opAllowed("direct") {
      return opDenied("direct")
    }

    return rawRequest(fetchargsIn)
  }

  // Is this raw-access op permitted by the SDK's allow.op option?
  private func opAllowed(_ op: String) -> Bool {
    guard let allow = gpath(options, "allow", "op").asString else { return false }
    return allow.contains(op)
  }

  private func opDenied(_ op: String) -> ThesmsworksSdk.VMap {
    let allow = gpath(options, "allow", "op").asString ?? ""
    let r = ThesmsworksSdk.VMap()
    r.entries["ok"] = .bool(false)
    r.entries["err"] = .nat(ThesmsworksError(
      op + "_allow",
      "ThesmsworksSDK: \(op): operation not allowed by SDK option "
        + "allow.op value: \"\(allow)\"", nil))
    return r
  }

  // Ungated request path shared by direct and graphql, each of which checks
  // its own allow.op token first. Private, rather than a flag on fetchargs:
  // a caller-supplied marker would let anyone opt straight back out of the
  // gate by passing it.
  private func rawRequest(_ fetchargsIn: ThesmsworksSdk.VMap?) -> ThesmsworksSdk.VMap {
    let utility = self.utility

    let fetchdef: ThesmsworksSdk.VMap
    do {
      fetchdef = try prepare(fetchargsIn)
    } catch {
      let r = ThesmsworksSdk.VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = .nat(error)
      return r
    }

    let fetchargs = fetchargsIn ?? ThesmsworksSdk.VMap()
    let ctrl = gp(fetchargs, "ctrl").asMap ?? ThesmsworksSdk.VMap()

    let ctx = utility.makeContext(["opname": "direct", "ctrl": ctrl], rootctx)

    let url = gp(fetchdef, "url").asString ?? ""

    let fetched: ThesmsworksSdk.Value
    do {
      fetched = try utility.fetcher(ctx, url, fetchdef)
    } catch {
      let r = ThesmsworksSdk.VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = .nat(error)
      return r
    }

    if isNil(fetched) {
      let r = ThesmsworksSdk.VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = .nat(ctx.makeError("direct_no_response", "response: undefined"))
      return r
    }

    if let fm = fetched.asMap {
      let status = toInt(gp(fm, "status"))
      let headers = gp(fm, "headers")

      // No-body responses (204, 304) and explicit zero content-length must
      // skip JSON parsing.
      var contentLength = ""
      if let hm = headers.asMap, let cl = hm.entries["content-length"], !isNil(cl) {
        contentLength = stringify(cl)
      }
      let noBody = status == 204 || status == 304 || contentLength == "0"

      var jsonData: ThesmsworksSdk.Value = .noval
      if !noBody, let jf = gp(fm, "json").asNative as? ThesmsworksSdk.NativeCall0 {
        jsonData = jf()
      }

      let r = ThesmsworksSdk.VMap()
      r.entries["ok"] = .bool(status >= 200 && status < 300)
      r.entries["status"] = .int(Int64(status))
      r.entries["headers"] = headers
      r.entries["data"] = jsonData
      return r
    }

    let r = ThesmsworksSdk.VMap()
    r.entries["ok"] = .bool(false)
    r.entries["err"] = .nat(ctx.makeError("direct_invalid", "invalid response type"))
    return r
  }

  // Raw GraphQL access: the pressure valve that makes the generated surface's
  // deliberate omissions (per-call selection sets, typed filter builders,
  // batching, subscriptions) livable — the whole schema stays reachable.
  //
  // Thin wrapper over the same prepare/fetch path direct uses, with the one
  // thing raw direct cannot do for GraphQL: a GraphQL failure rides HTTP 200
  // as a top-level `errors` array, so status alone would report a failed
  // query as ok.
  //
  // NOTE: like direct, this bypasses the feature pipeline — no retry,
  // ratelimit or paging features apply.
  public func graphql(
    _ query: String, _ variables: ThesmsworksSdk.VMap? = nil, _ ctrl: ThesmsworksSdk.VMap? = nil
  ) -> ThesmsworksSdk.VMap {
    if !opAllowed("graphql") {
      return opDenied("graphql")
    }

    let headers = ThesmsworksSdk.VMap()
    headers.entries["content-type"] = .string("application/json")

    let body = ThesmsworksSdk.VMap()
    body.entries["query"] = .string(query)
    body.entries["variables"] = .map(variables ?? ThesmsworksSdk.VMap())

    let fetchargs = ThesmsworksSdk.VMap()
    fetchargs.entries["method"] = .string("POST")
    fetchargs.entries["headers"] = .map(headers)
    fetchargs.entries["body"] = .map(body)
    fetchargs.entries["ctrl"] = .map(ctrl ?? ThesmsworksSdk.VMap())

    let res = rawRequest(fetchargs)

    // Errors are read BEFORE any status check: a GraphQL parse or validation
    // failure comes back as HTTP 400 carrying the standard { errors: [...] }
    // body, and the raw path represents a non-2xx as ok:false with no err —
    // so returning early on status would discard the server's own
    // diagnostics, which are the only useful part of that response.
    guard let errors = gp(gp(.map(res), "data"), "errors").asList,
          !errors.items.isEmpty else {
      return res
    }

    var msg = gp(errors.items[0], "message").asString ?? ""
    if msg.isEmpty { msg = "graphql error" }

    res.entries["ok"] = .bool(false)
    res.entries["err"] = .nat(ThesmsworksError(
      "graphql_error", "ThesmsworksSDK: graphql: " + msg, nil))
    res.entries["graphql"] = .list(errors)

    return res
  }


  // Batch returns a Batch entity bound to this client.
  // Idiomatic usage: try client.Batch().list(nil) or
  // try client.Batch().load(vm(("id", .string("..."))), nil).
  public func Batch(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return BatchEntity(self, entopts)
  }

  // BatchMessage returns a BatchMessage entity bound to this client.
  // Idiomatic usage: try client.BatchMessage().list(nil) or
  // try client.BatchMessage().load(vm(("id", .string("..."))), nil).
  public func BatchMessage(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return BatchMessageEntity(self, entopts)
  }

  // Credit returns a Credit entity bound to this client.
  // Idiomatic usage: try client.Credit().list(nil) or
  // try client.Credit().load(vm(("id", .string("..."))), nil).
  public func Credit(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return CreditEntity(self, entopts)
  }

  // Flash returns a Flash entity bound to this client.
  // Idiomatic usage: try client.Flash().list(nil) or
  // try client.Flash().load(vm(("id", .string("..."))), nil).
  public func Flash(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return FlashEntity(self, entopts)
  }

  // Message returns a Message entity bound to this client.
  // Idiomatic usage: try client.Message().list(nil) or
  // try client.Message().load(vm(("id", .string("..."))), nil).
  public func Message(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return MessageEntity(self, entopts)
  }

  // OneTimePassword returns a OneTimePassword entity bound to this client.
  // Idiomatic usage: try client.OneTimePassword().list(nil) or
  // try client.OneTimePassword().load(vm(("id", .string("..."))), nil).
  public func OneTimePassword(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return OneTimePasswordEntity(self, entopts)
  }

  // Schedule returns a Schedule entity bound to this client.
  // Idiomatic usage: try client.Schedule().list(nil) or
  // try client.Schedule().load(vm(("id", .string("..."))), nil).
  public func Schedule(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return ScheduleEntity(self, entopts)
  }

  // Swagger returns a Swagger entity bound to this client.
  // Idiomatic usage: try client.Swagger().list(nil) or
  // try client.Swagger().load(vm(("id", .string("..."))), nil).
  public func Swagger(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return SwaggerEntity(self, entopts)
  }

  // Util returns a Util entity bound to this client.
  // Idiomatic usage: try client.Util().list(nil) or
  // try client.Util().load(vm(("id", .string("..."))), nil).
  public func Util(_ entopts: VMap? = nil) -> ThesmsworksEntityBase {
    return UtilEntity(self, entopts)
  }


  public static func testSDK(_ testoptsIn: ThesmsworksSdk.VMap?, _ sdkoptsIn: ThesmsworksSdk.VMap?) -> ThesmsworksSDK {
    let sdkopts = clone(.map(sdkoptsIn ?? ThesmsworksSdk.VMap())).asMap ?? ThesmsworksSdk.VMap()

    let testopts = clone(.map(testoptsIn ?? ThesmsworksSdk.VMap())).asMap ?? ThesmsworksSdk.VMap()
    testopts.entries["active"] = .bool(true)

    _ = setpath(.map(sdkopts), jtp("feature", "test"), .map(testopts))

    let sdk = ThesmsworksSDK(sdkopts)
    sdk.mode = "test"
    return sdk
  }
}
