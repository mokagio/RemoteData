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

  /// A `.success` `Result` generates a `.success` `RemoteData` with the same value
  func testSuccessResultBecomesSuccessRemoteData() {
    let remoteData = Result<Int, TestError>.success(42).remoteData

    guard case .success(let value) = remoteData else {
      return XCTFail("Expected .success, got \(remoteData)")
    }

    XCTAssertEqual(value, 42)
  }

  /// A `.failure` `Result` generates a `.failure` `RemoteData` with the same error
  func testFailureResultBecomesFailureRemoteData() {
    let testError = TestError(name: "test")
    let remoteData = Result<Int, TestError>.failure(testError).remoteData

    guard case .failure(let error) = remoteData else {
      return XCTFail("Expected .failure, got \(remoteData)")
    }

    XCTAssertEqual(error, testError)
  }
}
