package voxgig.thesmsworkssdk.utility;

import voxgig.thesmsworkssdk.core.Context;

final class PrepareBody {

  private PrepareBody() {}

  static Object prepareBody(Context ctx) {
    if ("data".equals(ctx.op.input)) {
      if (Media.isRawRequest(ctx.point)) {
        return Media.rawBody(ctx.reqdata);
      }
      return ctx.utility.transformRequest.apply(ctx);
    }

    return null;
  }
}
