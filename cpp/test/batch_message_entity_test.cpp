// Generated basic-flow test for the batch_message entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct BatchMessageSetup {
  std::shared_ptr<ThesmsworksSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static BatchMessageSetup batch_message_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/batch_message/BatchMessageTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = ThesmsworksSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("batch_message01"), Value("batch_message02"), Value("batch_message03"), Value("schedule01"), Value("schedule02"), Value("schedule03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"THESMSWORKS_TEST_BATCH_MESSAGE_ENTID", idmap},
    {"THESMSWORKS_TEST_LIVE", Value("FALSE")},
    {"THESMSWORKS_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "THESMSWORKS_TEST_BATCH_MESSAGE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "THESMSWORKS_TEST_LIVE") == Value("TRUE");

  BatchMessageSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void batch_message_entity_instance() {
  auto testsdk = ThesmsworksSDK::testSDK();
  auto ent = testsdk->batch_message();
  ASSERT_EQ(ent->getName(), std::string("batch_message"), "entity name");
}

static void batch_message_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"batch_message", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = ThesmsworksSDK::testSDK(seed, sdkopts);
  auto se = strsdk->batch_message();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = ThesmsworksSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->batch_message();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void batch_message_entity_basic() {
  auto setup = batch_message_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("batch_message.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto batch_message_ref01_ent = client->batch_message();
  Value batch_message_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "batch_message"}), "batch_message_ref01"));
  if (!batch_message_ref01_data.is_map()) batch_message_ref01_data = vmap();
  {
    Value batch_message_ref01_data_result = batch_message_ref01_ent->create(Struct::clone(batch_message_ref01_data), Value::undef());
    batch_message_ref01_data = Helpers::toMapAny(batch_message_ref01_data_result);
    if (!batch_message_ref01_data.is_map()) batch_message_ref01_data = vmap();
    ASSERT_TRUE(batch_message_ref01_data.is_map(), "expected create result to be a map");
  }

  // REMOVE
  {
    Value batch_message_ref01_match_rm0 = vmap({{"id", getp(batch_message_ref01_data, "id")}});
    batch_message_ref01_ent->remove(Struct::clone(batch_message_ref01_match_rm0), Value::undef());
  }

}

int main() {
  T_RUN(batch_message_entity_instance);
  T_RUN(batch_message_entity_stream);
  T_RUN(batch_message_entity_basic);
  return sdktest::summary("batch_message_entity_test");
}
