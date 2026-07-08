# Thesmsworks SDK utility: feature_add
module ThesmsworksUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
