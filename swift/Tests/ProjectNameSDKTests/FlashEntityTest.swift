// flash entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class FlashEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Flash()
    XCTAssertEqual(ent.getName(), "flash")
  }
}
