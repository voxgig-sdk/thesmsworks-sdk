# Thesmsworks SDK exists test

require "minitest/autorun"
require_relative "../Thesmsworks_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = ThesmsworksSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
