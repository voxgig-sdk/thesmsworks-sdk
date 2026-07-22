package voxgig.thesmsworkssdk.entity;

import java.util.LinkedHashMap;
import java.util.Map;

import voxgig.thesmsworkssdk.core.Context;
import voxgig.thesmsworkssdk.core.Entity;
import voxgig.thesmsworkssdk.core.Helpers;
import voxgig.thesmsworkssdk.core.SdkClient;
import voxgig.thesmsworkssdk.utility.struct.Struct;

/** Swagger entity client for the Thesmsworks SDK. */
@SuppressWarnings({"unchecked", "unused"})
public class SwaggerEntity extends EntityBase {

  public SwaggerEntity(SdkClient client, Map<String, Object> entopts) {
    super("swagger", client, entopts);
  }

  @Override
  public Entity make() {
    Map<String, Object> opts = new LinkedHashMap<>(this.entopts);
    return new SwaggerEntity(this.client, opts);
  }

  @Override
  public Object load(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("load", this.name);
  }


  @Override
  public Object list(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("list", this.name);
  }


  @Override
  public Object create(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("create", this.name);
  }


  @Override
  public Object update(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("update", this.name);
  }


  @Override
  public Object remove(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("remove", this.name);
  }

}
