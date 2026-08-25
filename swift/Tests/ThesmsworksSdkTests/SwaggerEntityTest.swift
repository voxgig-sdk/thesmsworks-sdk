// swagger entity test (generated from the API model).

import XCTest

@testable import ThesmsworksSdk

final class SwaggerEntityTest: XCTestCase {
  func testInstance() {
    let sdk = ThesmsworksSDK.testSDK(nil, nil)
    let ent = sdk.Swagger()
    XCTAssertEqual(ent.getName(), "swagger")
  }
}
