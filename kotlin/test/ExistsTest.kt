package voxgig.thesmsworkssdk.sdktest

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test

import voxgig.thesmsworkssdk.core.ThesmsworksSDK

class ExistsTest {

  @Test
  fun testMode() {
    val testsdk = ThesmsworksSDK.testSDK()
    assertNotNull(testsdk, "expected non-nil SDK")
  }
}
