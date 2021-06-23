@testable import RemoteData
import XCTest

class ResultTests: XCTestCase {

  /// When init with a `.success` result, `self` is a `.success` with the same value
  func testInitResultSuccess() {
    let remoteData = RemoteData<Int, TestError>(.success(42))
    guard case .success(let value) = remoteData else {
      return XCTFail("Expected .success, got \(remoteData)")
    }

    XCTAssertEqual(value, 42)
  }

  /// When init with a `.failure` result, `self` is a `.failure` with the same error
  func testInitResultFailure() {
    let remoteData = RemoteData<Int, TestError>(.failure(TestError(name: "test")))
    guard case .failure(let error) = remoteData else {
      return XCTFail("Expected .failure, got \(remoteData)")
    }

    XCTAssertEqual(error, TestError(name: "test"))
  }
}
