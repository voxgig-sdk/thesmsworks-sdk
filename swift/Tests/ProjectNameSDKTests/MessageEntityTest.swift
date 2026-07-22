// message entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class MessageEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Message()
    XCTAssertEqual(ent.getName(), "message")
  }
}
