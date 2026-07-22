// batch_message entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class BatchMessageEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.BatchMessage()
    XCTAssertEqual(ent.getName(), "batch_message")
  }
}
