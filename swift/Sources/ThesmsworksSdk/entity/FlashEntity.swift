// Flash entity client for the Thesmsworks SDK.

import Foundation

public final class FlashEntity: ThesmsworksEntityBase {
  public init(_ client: ThesmsworksSDK, _ entopts: VMap? = nil) {
    super.init(client, entopts, "flash")
  }

  public override func make() -> Entity {
    return FlashEntity(client, cloneOpts())
  }

  // (load not defined by this API - base class throws unsupportedOp)

  // (list not defined by this API - base class throws unsupportedOp)

  // (create not defined by this API - base class throws unsupportedOp)

  // (update not defined by this API - base class throws unsupportedOp)

  // (remove not defined by this API - base class throws unsupportedOp)
}
