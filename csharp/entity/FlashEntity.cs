// Flash entity client for the Thesmsworks SDK.

using Voxgig.Struct;

namespace ThesmsworksSdk.Entity;

public class FlashEntity : ThesmsworksEntityBase
{
    public FlashEntity(ThesmsworksSDK client, Dictionary<string, object?>? entopts = null)
        : base(client, entopts, "flash")
    {
    }

    public override IEntity Make()
    {
        return new FlashEntity(client, CloneOpts());
    }

    // (load not defined by this API - base class throws UnsupportedOp)

    // (list not defined by this API - base class throws UnsupportedOp)

    // (create not defined by this API - base class throws UnsupportedOp)

    // (update not defined by this API - base class throws UnsupportedOp)

    // (remove not defined by this API - base class throws UnsupportedOp)
}
