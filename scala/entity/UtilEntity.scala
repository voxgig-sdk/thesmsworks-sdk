package voxgig.thesmsworkssdk.entity

import java.util.{LinkedHashMap, List => JList, Map => JMap}
import voxgig.thesmsworkssdk.core.{Context, Entity, Helpers, SdkClient}
import voxgig.thesmsworkssdk.utility.struct.Struct

// Util entity client for the Thesmsworks SDK.
class UtilEntity(client0: SdkClient, entopts0: JMap[String, Object]) extends EntityBase("util", client0, entopts0) {

  override def make(): Entity = {
    val opts = new LinkedHashMap[String, Object](this.entopts)
    new UtilEntity(this.client, opts)
  }


  override def load(reqmatch: JMap[String, Object], ctrl: JMap[String, Object]): Object = {
    val ctxmap = new LinkedHashMap[String, Object]()
    ctxmap.put("opname", "load")
    ctxmap.put("ctrl", ctrl)
    ctxmap.put("match", this.matchState)
    ctxmap.put("data", this.dataState)
    ctxmap.put("reqmatch", reqmatch)
    val ctx = this.utility.makeContext(ctxmap, this.entctx)

    runOp(ctx, () => {
      if (ctx.result != null) {
        if (ctx.result.resmatch != null) this.matchState = ctx.result.resmatch
        if (ctx.result.resdata != null) {
          val d = Helpers.toMapAny(Struct.clone(ctx.result.resdata))
          this.dataState = if (d == null) new LinkedHashMap[String, Object]() else d
        }
      }
    })
  }



  override def list(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("list", this.name)


  override def create(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("create", this.name)


  override def update(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("update", this.name)


  override def remove(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("remove", this.name)

}
