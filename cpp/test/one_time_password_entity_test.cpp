// Generated basic-flow test for the one_time_password entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct OneTimePasswordSetup {
  std::shared_ptr<ThesmsworksSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static OneTimePasswordSetup one_time_password_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/one_time_password/OneTimePasswordTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = ThesmsworksSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("one_time_password01"), Value("one_time_password02"), Value("one_time_password03"), Value("otp01"), Value("otp02"), Value("otp03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID", idmap},
    {"THESMSWORKS_TEST_LIVE", Value("FALSE")},
    {"THESMSWORKS_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "THESMSWORKS_TEST_ONE_TIME_PASSWORD_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "THESMSWORKS_TEST_LIVE") == Value("TRUE");

  OneTimePasswordSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void one_time_password_entity_instance() {
  auto testsdk = ThesmsworksSDK::testSDK();
  auto ent = testsdk->one_time_password();
  ASSERT_EQ(ent->getName(), std::string("one_time_password"), "entity name");
}

static void one_time_password_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"one_time_password", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = ThesmsworksSDK::testSDK(seed, sdkopts);
  auto se = strsdk->one_time_password();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = ThesmsworksSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->one_time_password();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void one_time_password_entity_basic() {
  auto setup = one_time_password_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : {"create", "load"}) {
    auto sk = is_control_skipped("entityOp", std::string("one_time_password.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto one_time_password_ref01_ent = client->one_time_password();
  Value one_time_password_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "one_time_password"}), "one_time_password_ref01"));
  if (!one_time_password_ref01_data.is_map()) one_time_password_ref01_data = vmap();
  {
    Value one_time_password_ref01_data_result = one_time_password_ref01_ent->create(Struct::clone(one_time_password_ref01_data), Value::undef());
    one_time_password_ref01_data = Helpers::toMapAny(one_time_password_ref01_data_result);
    if (!one_time_password_ref01_data.is_map()) one_time_password_ref01_data = vmap();
    ASSERT_TRUE(one_time_password_ref01_data.is_map(), "expected create result to be a map");
  }

  // LOAD
  Value one_time_password_ref01_match_dt0 = vmap();
  Value one_time_password_ref01_data_dt0_loaded = one_time_password_ref01_ent->load(one_time_password_ref01_match_dt0, Value::undef());
  ASSERT_TRUE(!one_time_password_ref01_data_dt0_loaded.is_undef(), "expected load result to be non-nil");

}

int main() {
  T_RUN(one_time_password_entity_instance);
  T_RUN(one_time_password_entity_stream);
  T_RUN(one_time_password_entity_basic);
  return sdktest::summary("one_time_password_entity_test");
}
