// batch entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class BatchEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Batch()
    XCTAssertEqual(ent.getName(), "batch")
  }
}
