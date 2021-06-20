@testable import RemoteData
import XCTest

class MapTests: XCTestCase {

  let f: (String) -> Int = { $0.count }

  /// `map`, when `self` is `.success`, returns a new `.success` `RemoteData` with associated value
  /// the result of the given `transform` with input the associated value of `self`.
  func testMapSuccess() {
    let sut = RemoteData<String, TestError>.success("foo")
    let result = sut.map(f)

    switch result {
    case .success(let value): XCTAssertEqual(value, 3)
    case _: XCTFail("Expected mapped RemoteData to be .success, got \(result)")
    }
  }

  /// `map`, when `self` is `.failure`, returns a new `.failure` `RemoteData`.
  func testMapFailure() {
    let error = TestError(name: "foo")
    let sut = RemoteData<String, TestError>.failure(error)
    let result = sut.map(f)

    switch result {
    case .failure(let resultError): XCTAssertEqual(resultError, error)
    case _: XCTFail("Expected mapped RemoteData to be .success, got \(result)")
    }
  }

  /// `map`, when `self` is `.loading`, returns a new `.loading` `RemoteData`.
  func testMapLoading() {
    let sut = RemoteData<String, TestError>.loading
    let result = sut.map(f)

    switch result {
    case .loading: break
    case _: XCTFail("Expected mapped RemoteData to be .success, got \(result)")
    }
  }

  /// `map`, when `self` is `.notAsked`, returns a new `.notAsked` `RemoteData`.
  func testMapNotAsked() {
    let sut = RemoteData<String, TestError>.notAsked
    let result = sut.map(f)

    switch result {
    case .notAsked: break
    case _: XCTFail("Expected mapped RemoteData to be .success, got \(result)")
    }
  }
}
