// Generated instance test for the util entity.

#include "ctest.h"

int main(void) {
  ThesmsworksSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = thesmsworks_util(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "util", "entity get_name");

  // stream(): runs the list op through the full pipeline and returns a List
  // of items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  {
    voxgig_value* seed = cmap(1, "entity",
      cmap(1, "util",
        cmap(2,
          "strm01", cmap(1, "id", v_str("strm01")),
          "strm02", cmap(1, "id", v_str("strm02")))));
    voxgig_value* sdkopts = cmap(1, "feature",
      cmap(1, "streaming", cmap(1, "active", v_bool(true))));

    ThesmsworksSDK* strsdk = test_sdk(seed, sdkopts);
    Entity* se = thesmsworks_util(strsdk, NULL);
    PNError* serr = NULL;
    voxgig_value* items = util_stream(se, "list", NULL, NULL, &serr);
    CHECK(serr == NULL, "stream: no error");
    CHECK(v_is_list(items), "stream: returns a list");
    CHECK_INT_EQ((int64_t)voxgig_as_list(items)->len, 2, "stream: yields both items");

    // Fallback: streaming inactive still yields both materialised items.
    ThesmsworksSDK* plainsdk = test_sdk(seed, NULL);
    Entity* pe = thesmsworks_util(plainsdk, NULL);
    PNError* perr = NULL;
    voxgig_value* pitems = util_stream(pe, "list", NULL, NULL, &perr);
    CHECK(perr == NULL, "stream fallback: no error");
    CHECK_INT_EQ((int64_t)voxgig_as_list(pitems)->len, 2, "stream fallback: yields both items");
  }

  TEST_SUMMARY("util_entity");
}
