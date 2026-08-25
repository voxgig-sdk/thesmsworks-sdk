// one_time_password entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class OneTimePasswordEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.OneTimePassword()
    XCTAssertEqual(ent.getName(), "one_time_password")
  }
}
