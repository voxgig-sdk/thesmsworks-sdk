package voxgig.thesmsworkssdk.utility;

import java.util.LinkedHashMap;
import java.util.Map;

import voxgig.thesmsworkssdk.core.Context;
import voxgig.thesmsworkssdk.core.Helpers;
import voxgig.thesmsworkssdk.core.Response;
import voxgig.thesmsworkssdk.core.Result;

final class ResultHeaders {

  private ResultHeaders() {}

  static Result resultHeaders(Context ctx) {
    Response response = ctx.response;
    Result result = ctx.result;

    if (result != null) {
      if (response != null && response.headers != null) {
        Map<String, Object> hm = Helpers.toMapAny(response.headers);
        if (hm != null) {
          result.headers = hm;
        }
        else {
          result.headers = new LinkedHashMap<>();
        }
      }
      else {
        result.headers = new LinkedHashMap<>();
      }
    }

    return result;
  }
}
