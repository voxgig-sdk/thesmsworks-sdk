// Generated basic-flow test for the message entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct MessageSetup {
  std::shared_ptr<ThesmsworksSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static MessageSetup message_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/message/MessageTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = ThesmsworksSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("message01"), Value("message02"), Value("message03"), Value("schedule01"), Value("schedule02"), Value("schedule03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"THESMSWORKS_TEST_MESSAGE_ENTID", idmap},
    {"THESMSWORKS_TEST_LIVE", Value("FALSE")},
    {"THESMSWORKS_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "THESMSWORKS_TEST_MESSAGE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "THESMSWORKS_TEST_LIVE") == Value("TRUE");

  MessageSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void message_entity_instance() {
  auto testsdk = ThesmsworksSDK::testSDK();
  auto ent = testsdk->message();
  ASSERT_EQ(ent->getName(), std::string("message"), "entity name");
}

static void message_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"message", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = ThesmsworksSDK::testSDK(seed, sdkopts);
  auto se = strsdk->message();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = ThesmsworksSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->message();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void message_entity_basic() {
  auto setup = message_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "load", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("message.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto message_ref01_ent = client->message();
  Value message_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "message"}), "message_ref01"));
  if (!message_ref01_data.is_map()) message_ref01_data = vmap();
  {
    Value message_ref01_data_result = message_ref01_ent->create(Struct::clone(message_ref01_data), Value::undef());
    message_ref01_data = Helpers::toMapAny(message_ref01_data_result);
    if (!message_ref01_data.is_map()) message_ref01_data = vmap();
    ASSERT_TRUE(message_ref01_data.is_map(), "expected create result to be a map");
  }

  // LOAD
  Value message_ref01_match_dt0 = vmap();
  Value message_ref01_data_dt0_loaded = message_ref01_ent->load(message_ref01_match_dt0, Value::undef());
  ASSERT_TRUE(!message_ref01_data_dt0_loaded.is_undef(), "expected load result to be non-nil");

  // REMOVE
  {
    Value message_ref01_match_rm0 = vmap({{"id", getp(message_ref01_data, "id")}});
    message_ref01_ent->remove(Struct::clone(message_ref01_match_rm0), Value::undef());
  }

}

int main() {
  T_RUN(message_entity_instance);
  T_RUN(message_entity_stream);
  T_RUN(message_entity_basic);
  return sdktest::summary("message_entity_test");
}
