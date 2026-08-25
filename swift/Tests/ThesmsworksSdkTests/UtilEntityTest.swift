// util entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class UtilEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Util()
    XCTAssertEqual(ent.getName(), "util")
  }
}
