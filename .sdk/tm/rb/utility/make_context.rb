# Thesmsworks SDK utility: make_context
require_relative '../core/context'
module ThesmsworksUtilities
  MakeContext = ->(ctxmap, basectx) {
    ThesmsworksContext.new(ctxmap, basectx)
  }
end
