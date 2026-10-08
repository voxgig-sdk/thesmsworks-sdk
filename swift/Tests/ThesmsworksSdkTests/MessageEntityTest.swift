// message entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class MessageEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Message()
    XCTAssertEqual(ent.getName(), "message")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
