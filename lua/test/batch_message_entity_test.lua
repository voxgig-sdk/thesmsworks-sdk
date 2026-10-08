-- BatchMessage entity test

local json = require("dkjson")
local vs = require("utility.struct.struct")
local sdk = require("thesmsworks_sdk")
local helpers = require("core.helpers")
local runner = require("test.runner")

local _test_dir = debug.getinfo(1, "S").source:match("^@(.+/)")  or "./"

-- main.kit.test.live.strict is true (the default is true): a live
-- request that fails, or a live test missing an input it needs,
-- fails the test.
-- An account with no record for a test to read skips it either way.
local LIVE_STRICT = true


describe("BatchMessageEntity", function()
  it("should create instance", function()
    local testsdk = sdk.test(nil, nil)
    local ent = testsdk:BatchMessage(nil)
    assert.is_not_nil(ent)
  end)

  it("should refuse an invalid request", function()
    local config = require("config_shared")()
    if type(config.feature) ~= "table" or config.feature.validate == nil then
      pending("feature not present in this SDK: validate")
      return
    end
    local client = sdk.test(nil, { feature = { validate = { active = true } } })
    local _, err = client:BatchMessage(nil):create({ ["ai"] = "x", ["content"] = "x", ["destinations"] = "x", ["sender"] = "x" }, nil)
    assert.are.equal("validate_failed", type(err) == "table" and err.code or nil)
  end)

  it("should run basic flow", function()
    local setup = batch_message_basic_setup(nil)
    -- Per-op sdk-test-control.json skip.
    local _live = setup.live or false
    for _, _op in ipairs({"create"}) do
      local _should_skip, _reason = runner.is_control_skipped("entityOp", "batch_message." .. _op, _live and "live" or "unit")
      if _should_skip then
        pending(_reason or "skipped via sdk-test-control.json")
        return
      end
    end
    local client = setup.client

    -- CREATE
    local batch_message_ref01_ent = client:BatchMessage(nil)
    local batch_message_ref01_data = helpers.to_map(vs.getprop(
      vs.getpath(setup.data, "new.batch_message"), "batch_message_ref01"))

    local batch_message_ref01_data_result, err = batch_message_ref01_ent:create(batch_message_ref01_data, nil)
    assert.is_nil(err)
    batch_message_ref01_data = helpers.to_map(type(batch_message_ref01_data_result) == 'table' and batch_message_ref01_data_result.data_get and batch_message_ref01_data_result:data_get() or batch_message_ref01_data_result)
    assert.is_not_nil(batch_message_ref01_data)

  end)
end)

function batch_message_basic_setup(extra)
  runner.load_env_local()

  local entity_data_file = _test_dir .. "../../.sdk/test/entity/batch_message/BatchMessageTestData.json"
  local f = io.open(entity_data_file, "r")
  if f == nil then
    error("failed to read batch_message test data: " .. entity_data_file)
  end
  local entity_data_source = f:read("*a")
  f:close()

  local entity_data = json.decode(entity_data_source)

  local options = {}
  options["entity"] = entity_data["existing"]

  local client = sdk.test(options, extra)

  -- Generate idmap via transform.
  local idmap = vs.transform(
    { "batch_message01", "batch_message02", "batch_message03" },
    {
      ["`$PACK`"] = { "", {
        ["`$KEY`"] = "`$COPY`",
        ["`$VAL`"] = { "`$FORMAT`", "upper", "`$COPY`" },
      }},
    }
  )

  -- Whether *_ENTID supplied the idmap, read before env_override consumes
  -- it: without it, the ids a live flow binds are the fixture's synthetic ones.
  local entid_env_raw = os.getenv("THESMSWORKS_TEST_BATCH_MESSAGE_ENTID")
  local idmap_overridden = entid_env_raw ~= nil and entid_env_raw:match("^%s*{") ~= nil

  local env = runner.env_override({
    ["THESMSWORKS_TEST_BATCH_MESSAGE_ENTID"] = idmap,
    ["THESMSWORKS_TEST_LIVE"] = "FALSE",
    ["THESMSWORKS_TEST_EXPLAIN"] = "FALSE",
    ["THESMSWORKS_APIKEY"] = "",
  })

  local idmap_resolved = helpers.to_map(
    env["THESMSWORKS_TEST_BATCH_MESSAGE_ENTID"])
  if idmap_resolved == nil then
    idmap_resolved = helpers.to_map(idmap)
  end

  if env["THESMSWORKS_TEST_LIVE"] == "TRUE" then
    local merged_opts = vs.merge({
      -- FIRST, so the generated fields below win: sdk-test-control.json's
      -- test.client.options adds to the live client, it does not redirect it.
      runner.live_client_options(),
      {
        apikey = env["THESMSWORKS_APIKEY"],
      },
      extra or {},
    })
    client = sdk.new(helpers.to_map(merged_opts))
  end

  local live = env["THESMSWORKS_TEST_LIVE"] == "TRUE"
  return {
    client = client,
    data = entity_data,
    idmap = idmap_resolved,
    env = env,
    explain = env["THESMSWORKS_TEST_EXPLAIN"] == "TRUE",
    live = live,
    synthetic_only = live and not idmap_overridden,
    now = os.time() * 1000,
  }
end
