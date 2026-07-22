// schedule entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class ScheduleEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Schedule()
    XCTAssertEqual(ent.getName(), "schedule")
  }
}
