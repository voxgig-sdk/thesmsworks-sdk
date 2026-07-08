# Thesmsworks SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

ThesmsworksUtility.registrar = ->(u) {
  u.clean = ThesmsworksUtilities::Clean
  u.done = ThesmsworksUtilities::Done
  u.make_error = ThesmsworksUtilities::MakeError
  u.feature_add = ThesmsworksUtilities::FeatureAdd
  u.feature_hook = ThesmsworksUtilities::FeatureHook
  u.feature_init = ThesmsworksUtilities::FeatureInit
  u.fetcher = ThesmsworksUtilities::Fetcher
  u.make_fetch_def = ThesmsworksUtilities::MakeFetchDef
  u.make_context = ThesmsworksUtilities::MakeContext
  u.make_options = ThesmsworksUtilities::MakeOptions
  u.make_request = ThesmsworksUtilities::MakeRequest
  u.make_response = ThesmsworksUtilities::MakeResponse
  u.make_result = ThesmsworksUtilities::MakeResult
  u.make_point = ThesmsworksUtilities::MakePoint
  u.make_spec = ThesmsworksUtilities::MakeSpec
  u.make_url = ThesmsworksUtilities::MakeUrl
  u.param = ThesmsworksUtilities::Param
  u.prepare_auth = ThesmsworksUtilities::PrepareAuth
  u.prepare_body = ThesmsworksUtilities::PrepareBody
  u.prepare_headers = ThesmsworksUtilities::PrepareHeaders
  u.prepare_method = ThesmsworksUtilities::PrepareMethod
  u.prepare_params = ThesmsworksUtilities::PrepareParams
  u.prepare_path = ThesmsworksUtilities::PreparePath
  u.prepare_query = ThesmsworksUtilities::PrepareQuery
  u.result_basic = ThesmsworksUtilities::ResultBasic
  u.result_body = ThesmsworksUtilities::ResultBody
  u.result_headers = ThesmsworksUtilities::ResultHeaders
  u.transform_request = ThesmsworksUtilities::TransformRequest
  u.transform_response = ThesmsworksUtilities::TransformResponse
}
