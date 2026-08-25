// Thesmsworks SDK exists test.

import XCTest

@testable import ThesmsworksSdk

final class ExistsTest: XCTestCase {
  func testMode() {
    let testsdk = ThesmsworksSDK.testSDK(nil, nil)
    XCTAssertEqual(testsdk.mode, "test")
  }
}
