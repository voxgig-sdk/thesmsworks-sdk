// credit entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class CreditEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Credit()
    XCTAssertEqual(ent.getName(), "credit")
  }
}
