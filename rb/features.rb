# Thesmsworks SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module ThesmsworksFeatures
  def self.make_feature(name)
    case name
    when "base"
      ThesmsworksBaseFeature.new
    when "test"
      ThesmsworksTestFeature.new
    else
      ThesmsworksBaseFeature.new
    end
  end
end
