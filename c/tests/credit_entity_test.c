// Generated instance test for the credit entity.

#include "ctest.h"

int main(void) {
  ThesmsworksSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = thesmsworks_credit(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "credit", "entity get_name");

  TEST_SUMMARY("credit_entity");
}
