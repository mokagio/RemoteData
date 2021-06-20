import XCTest
import RemoteData

class InitTests: XCTestCase {

  /// `init(value:)` create a `.success` `RemoteData` with the given `value` as the associate
  /// value.
  func testInitValue() {
    let value = "foo"
    let remoteData = RemoteData<String, TestError>(value: value)

    switch remoteData {
    case .success(let value): XCTAssertEqual(value, "foo")
    case _: XCTFail("Expected error mapped RemoteData to be .success, got \(remoteData)")
    }
  }
}
