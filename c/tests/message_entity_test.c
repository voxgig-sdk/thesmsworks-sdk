// Generated instance test for the message entity.

#include "ctest.h"

int main(void) {
  ThesmsworksSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = thesmsworks_message(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "message", "entity get_name");

  TEST_SUMMARY("message_entity");
}
