// Thesmsworks SDK client.

import Foundation

public final class ThesmsworksSDK {
  public var mode = "live"
  private var options: VMap = VMap()
  private let utility: Utility
  public var features: [BaseFeature] = []
  private var rootctx: Context!

  public init(_ optionsIn: VMap? = nil) {
    utility = Utility()

    let config = SdkConfig.makeConfig()

    var ctxmap: [String: Any?] = [
      "client": self,
      "utility": utility,
      "config": config,
      "shared": VMap(),
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
    let featureOpts = gp(options, "feature").asMap ?? VMap()
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

  public func optionsMap() -> VMap {
    return clone(.map(options)).asMap ?? VMap()
  }

  public func getUtility() -> Utility {
    return Utility.copy(utility)
  }

  public func getRootCtx() -> Context {
    return rootctx
  }

  public func prepare(_ fetchargsIn: VMap?) throws -> VMap {
    let utility = self.utility

    let fetchargs = fetchargsIn ?? VMap()

    let ctrl = gp(fetchargs, "ctrl").asMap ?? VMap()

    let ctx = utility.makeContext(["opname": "prepare", "ctrl": ctrl], rootctx)

    let options = self.options

    let path = gp(fetchargs, "path").asString ?? ""
    var method = gp(fetchargs, "method").asString ?? ""
    if method == "" { method = "GET" }

    let pathParams = gp(fetchargs, "params").asMap ?? VMap()
    let query = gp(fetchargs, "query").asMap ?? VMap()

    let headers = utility.prepareHeaders(ctx)

    let basev = gp(options, "base").asString ?? ""
    let prefix = gp(options, "prefix").asString ?? ""
    let suffix = gp(options, "suffix").asString ?? ""

    let specmap = VMap()
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
    ctx.spec = Spec(specmap)

    // Merge user-provided headers.
    if let uhm = gp(fetchargs, "headers").asMap {
      for (k, v) in uhm.entries {
        ctx.spec!.headers.entries[k] = v
      }
    }

    _ = try utility.prepareAuth(ctx)

    return try utility.makeFetchDef(ctx)
  }

  public func direct(_ fetchargsIn: VMap?) -> VMap {
    let utility = self.utility

    let fetchdef: VMap
    do {
      fetchdef = try prepare(fetchargsIn)
    } catch {
      let r = VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = .nat(error)
      return r
    }

    let fetchargs = fetchargsIn ?? VMap()
    let ctrl = gp(fetchargs, "ctrl").asMap ?? VMap()

    let ctx = utility.makeContext(["opname": "direct", "ctrl": ctrl], rootctx)

    let url = gp(fetchdef, "url").asString ?? ""

    let fetched: Value
    do {
      fetched = try utility.fetcher(ctx, url, fetchdef)
    } catch {
      let r = VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = .nat(error)
      return r
    }

    if isNil(fetched) {
      let r = VMap()
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

      var jsonData: Value = .noval
      if !noBody, let jf = gp(fm, "json").asNative as? NativeCall0 {
        jsonData = jf()
      }

      let r = VMap()
      r.entries["ok"] = .bool(status >= 200 && status < 300)
      r.entries["status"] = .int(Int64(status))
      r.entries["headers"] = headers
      r.entries["data"] = jsonData
      return r
    }

    let r = VMap()
    r.entries["ok"] = .bool(false)
    r.entries["err"] = .nat(ctx.makeError("direct_invalid", "invalid response type"))
    return r
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


  public static func testSDK(_ testoptsIn: VMap?, _ sdkoptsIn: VMap?) -> ThesmsworksSDK {
    let sdkopts = clone(.map(sdkoptsIn ?? VMap())).asMap ?? VMap()

    let testopts = clone(.map(testoptsIn ?? VMap())).asMap ?? VMap()
    testopts.entries["active"] = .bool(true)

    _ = setpath(.map(sdkopts), jtp("feature", "test"), .map(testopts))

    let sdk = ThesmsworksSDK(sdkopts)
    sdk.mode = "test"
    return sdk
  }
}
