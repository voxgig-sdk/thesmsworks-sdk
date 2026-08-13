// Generated instance test for the batch entity.

#include "ctest.h"

int main(void) {
  ThesmsworksSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = thesmsworks_batch(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "batch", "entity get_name");

  TEST_SUMMARY("batch_entity");
}
