// Generated basic-flow test for the message_message entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct MessageMessageSetup {
  std::shared_ptr<ThesmsworksSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static MessageMessageSetup message_message_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/message_message/MessageMessageTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = ThesmsworksSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("message_message01"), Value("message_message02"), Value("message_message03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID", idmap},
    {"THESMSWORKS_TEST_LIVE", Value("FALSE")},
    {"THESMSWORKS_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "THESMSWORKS_TEST_MESSAGE_MESSAGE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "THESMSWORKS_TEST_LIVE") == Value("TRUE");

  MessageMessageSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void message_message_entity_instance() {
  auto testsdk = ThesmsworksSDK::testSDK();
  auto ent = testsdk->message_message();
  ASSERT_EQ(ent->getName(), std::string("message_message"), "entity name");
}


static bool message_message_has_feature(const std::string& name) {
  Value fm = Helpers::toMapAny(getp(sharedConfig(), "feature"));
  return fm.is_map() && !getp(fm, name).is_undef();
}

static void message_message_entity_validate() {
  if (!message_message_has_feature("validate")) {
    std::cerr << "skip: feature not present in this SDK: validate\n";
    return;
  }
  auto vsdk = ThesmsworksSDK::testSDK(Value::undef(), vmap({{"feature",
      vmap({{"validate", vmap({{"active", Value(true)}})}})}}));
  std::string code;
  try {
    vsdk->message_message()->load(vmap({{"id", Value(1)}}), Value::undef());
  } catch (const SdkErrorPtr& err) {
    code = err->code;
  }
  ASSERT_EQ(code, std::string("validate_failed"), "an invalid request fails with validate_failed");
}

static void message_message_entity_basic() {
  auto setup = message_message_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "load", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("message_message.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto message_message_ref01_ent = client->message_message();
  Value message_message_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "message_message"}), "message_message_ref01"));
  if (!message_message_ref01_data.is_map()) message_message_ref01_data = vmap();
  {
    Value message_message_ref01_data_result = message_message_ref01_ent->create(Struct::clone(message_message_ref01_data), Value::undef())->data();
    message_message_ref01_data = Helpers::toMapAny(message_message_ref01_data_result);
    if (!message_message_ref01_data.is_map()) message_message_ref01_data = vmap();
    ASSERT_TRUE(message_message_ref01_data.is_map(), "expected create result to be a map");
    ASSERT_TRUE(!getp(message_message_ref01_data, "id").is_undef(), "expected created entity to have an id");
  }

  // LOAD
  Value message_message_ref01_match_dt0 = vmap({{"id", getp(message_message_ref01_data, "id")}});
  Value message_message_ref01_data_dt0_loaded = message_message_ref01_ent->load(Struct::clone(message_message_ref01_match_dt0), Value::undef())->data();
  Value message_message_ref01_data_dt0_load_result = Helpers::toMapAny(message_message_ref01_data_dt0_loaded);
  ASSERT_TRUE(message_message_ref01_data_dt0_load_result.is_map(), "expected load result to be a map");
  ASSERT_EQ_VAL(getp(message_message_ref01_data_dt0_load_result, "id"), getp(message_message_ref01_data, "id"), "expected load result id to match");

  // REMOVE
  {
    Value message_message_ref01_match_rm0 = vmap({{"id", getp(message_message_ref01_data, "id")}});
    message_message_ref01_ent->remove(Struct::clone(message_message_ref01_match_rm0), Value::undef());
  }

}

int main() {
  T_RUN(message_message_entity_instance);
  T_RUN(message_message_entity_validate);
  T_RUN(message_message_entity_basic);
  return sdktest::summary("message_message_entity_test");
}
