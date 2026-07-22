package voxgig.thesmsworkssdk.entity

import java.util.{LinkedHashMap, List => JList, Map => JMap}
import voxgig.thesmsworkssdk.core.{Context, Entity, Helpers, SdkClient}
import voxgig.thesmsworkssdk.utility.struct.Struct

// Swagger entity client for the Thesmsworks SDK.
class SwaggerEntity(client0: SdkClient, entopts0: JMap[String, Object]) extends EntityBase("swagger", client0, entopts0) {

  override def make(): Entity = {
    val opts = new LinkedHashMap[String, Object](this.entopts)
    new SwaggerEntity(this.client, opts)
  }

  override def load(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("load", this.name)


  override def list(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("list", this.name)


  override def create(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("create", this.name)


  override def update(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("update", this.name)


  override def remove(req: java.util.Map[String, Object], ctrl: java.util.Map[String, Object]): Object =
    throw Helpers.unsupportedOp("remove", this.name)

}
