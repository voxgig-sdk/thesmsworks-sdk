// batch_message entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class BatchMessageEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.BatchMessage()
    XCTAssertEqual(ent.getName(), "batch_message")
  }

  // An invalid request fails with validate's own error, before it is sent.
  func testValidate() throws {
    try XCTSkipUnless(BatchMessageEntityTest.hasFeature("validate"), "feature not present in this SDK: validate")
    let client = ThesmsworksSDK.testSDK(nil, vm(("feature", .map(vm(("validate", .map(vm(("active", .bool(true))))))))))
    var err: Error? = nil
    do { _ = try client.BatchMessage().create(vm(("ai", .string("x")), ("content", .string("x")), ("destinations", .string("x")), ("sender", .string("x"))), nil) } catch { err = error }
    XCTAssertEqual((err as? ThesmsworksError)?.code, "validate_failed",
      "expected validate_failed, got \(String(describing: err))")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
