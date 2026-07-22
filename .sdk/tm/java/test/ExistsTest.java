package JAVAPACKAGE.sdktest;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import JAVAPACKAGE.core.ThesmsworksSDK;

public class ExistsTest {

  @Test
  public void testMode() {
    ThesmsworksSDK testsdk = ThesmsworksSDK.testSDK();
    assertNotNull(testsdk, "expected non-nil SDK");
  }
}
