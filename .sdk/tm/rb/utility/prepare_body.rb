# Thesmsworks SDK utility: prepare_body
require_relative 'media'
module ThesmsworksUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return ThesmsworksUtilities.raw_body(ctx.reqdata) if ThesmsworksUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
