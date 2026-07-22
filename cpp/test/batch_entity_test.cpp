// Generated basic-flow test for the batch entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct BatchSetup {
  std::shared_ptr<ThesmsworksSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static BatchSetup batch_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/batch/BatchTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = ThesmsworksSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("batch01"), Value("batch02"), Value("batch03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"THESMSWORKS_TEST_BATCH_ENTID", idmap},
    {"THESMSWORKS_TEST_LIVE", Value("FALSE")},
    {"THESMSWORKS_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "THESMSWORKS_TEST_BATCH_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "THESMSWORKS_TEST_LIVE") == Value("TRUE");

  BatchSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void batch_entity_instance() {
  auto testsdk = ThesmsworksSDK::testSDK();
  auto ent = testsdk->batch();
  ASSERT_EQ(ent->getName(), std::string("batch"), "entity name");
}

static void batch_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"batch", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = ThesmsworksSDK::testSDK(seed, sdkopts);
  auto se = strsdk->batch();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = ThesmsworksSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->batch();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void batch_entity_basic() {
  auto setup = batch_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : {"load"}) {
    auto sk = is_control_skipped("entityOp", std::string("batch.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;

  // Bootstrap entity data from existing test data (no create step in flow).
  Value batch_ref01_data_raw = Helpers::toMapAny(Struct::getpath(setup.data, {"existing", "batch"}));
  {
    std::vector<Value> its = Struct::items(batch_ref01_data_raw);
    batch_ref01_data = its.empty() ? vmap() : Helpers::toMapAny(pair_val(its[0]));
    if (!batch_ref01_data.is_map()) batch_ref01_data = vmap();
  }
  // LOAD
  auto batch_ref01_ent = client->batch();
  Value batch_ref01_match_dt0 = vmap();
  Value batch_ref01_data_dt0_loaded = batch_ref01_ent->load(batch_ref01_match_dt0, Value::undef());
  ASSERT_TRUE(!batch_ref01_data_dt0_loaded.is_undef(), "expected load result to be non-nil");

}

int main() {
  T_RUN(batch_entity_instance);
  T_RUN(batch_entity_stream);
  T_RUN(batch_entity_basic);
  return sdktest::summary("batch_entity_test");
}
