# MessageMessage entity test

require "minitest/autorun"
require "json"
require_relative "../Thesmsworks_sdk"
require_relative "runner"

class MessageMessageEntityTest < Minitest::Test
  # main.kit.test.live.strict is true (the default is true): a live
  # request that fails, or a live test missing an input it needs,
  # fails the test.
  # An account with no record for a test to read skips it either way.
  LIVE_STRICT = true

  def test_create_instance
    testsdk = ThesmsworksSDK.test(nil, nil)
    ent = testsdk.MessageMessage(nil)
    assert !ent.nil?
  end

  def test_validate
    cfg = ThesmsworksConfig.shared_config
    unless cfg["feature"].is_a?(Hash) && cfg["feature"].key?("validate")
      skip("feature not present in this SDK: validate")
    end
    client = ThesmsworksSDK.test(nil, { "feature" => { "validate" => { "active" => true } } })
    err = assert_raises(StandardError) do
      client.MessageMessage(nil).load({ "id" => 1 }, nil)
    end
    assert_equal "validate_failed", err.code
  end

  def test_basic_flow
    setup = message_message_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create", "load", "remove"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "message_message." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    client = setup[:client]

    # CREATE
    message_message_ref01_ent = client.MessageMessage(nil)
    message_message_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.message_message"), "message_message_ref01"))

    message_message_ref01_data_result = message_message_ref01_ent.create(message_message_ref01_data, nil)
    message_message_ref01_data = Helpers.to_map(message_message_ref01_data_result.respond_to?(:data_get) ? message_message_ref01_data_result.data_get : message_message_ref01_data_result)
    assert !message_message_ref01_data.nil?
    assert !message_message_ref01_data["id"].nil?

    # LOAD
    message_message_ref01_match_dt0 = {
      "id" => message_message_ref01_data["id"],
    }
    message_message_ref01_data_dt0_loaded = message_message_ref01_ent.load(message_message_ref01_match_dt0, nil)
    message_message_ref01_data_dt0_load_result = Helpers.to_map(message_message_ref01_data_dt0_loaded.respond_to?(:data_get) ? message_message_ref01_data_dt0_loaded.data_get : message_message_ref01_data_dt0_loaded)
    assert !message_message_ref01_data_dt0_load_result.nil?
    assert_equal message_message_ref01_data_dt0_load_result["id"], message_message_ref01_data["id"]

    # REMOVE
    message_message_ref01_match_rm0 = {
      "id" => message_message_ref01_data["id"],
    }
    message_message_ref01_ent.remove(message_message_ref01_match_rm0, nil)

  end
end

def message_message_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "message_message", "MessageMessageTestData.json")
  entity_data_source = File.read(entity_data_file, encoding: "UTF-8")
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = ThesmsworksSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["message_message01", "message_message02", "message_message03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Whether *_ENTID supplied the idmap, read before env_override consumes
  # it: without it, the ids a live flow binds are the fixture's synthetic ones.
  entid_env_raw = ENV["THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID" => idmap,
    "THESMSWORKS_TEST_LIVE" => "FALSE",
    "THESMSWORKS_TEST_EXPLAIN" => "FALSE",
    "THESMSWORKS_APIKEY" => "",
  })

  idmap_resolved = Helpers.to_map(
    env["THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["THESMSWORKS_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      Runner.live_client_options,
      {
        "apikey" => env["THESMSWORKS_APIKEY"],
      },
      extra || {},
    ])
    client = ThesmsworksSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["THESMSWORKS_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["THESMSWORKS_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
