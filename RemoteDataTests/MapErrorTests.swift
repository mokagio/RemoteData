import XCTest
import RemoteData

class MapErrorTests: XCTestCase {

  let g: (TestError) -> OtherTestError = { OtherTestError(number: $0.name.count) }

  /// `mapError`, when `self` is `.failure`, returns a new `.failure` `RemoteData`.
  func testMapErrorFailure() {
    let error = TestError(name: "foo")
    let sut = RemoteData<String, TestError>.failure(error)
    let result = sut.mapError(g)

    switch result {
    case .failure(let resultError): XCTAssertEqual(resultError, OtherTestError(number: 3))
    case _: XCTFail("Expected error mapped RemoteData to be .success, got \(result)")
    }
  }

  /// `mapError`, when `self` is `.success`, returns a new `.succes` `RemoteData` with the same
  /// associated value.
  func testMapErrorSuccess() {
    let sut = RemoteData<String, TestError>.success("foo")
    let result = sut.mapError(g)

    switch result {
    case .success(let value): XCTAssertEqual(value, "foo")
    case _: XCTFail("Expected error mapped RemoteData to be .success, got \(result)")
    }
  }

  /// `mapError`, when `self` is `.loading`, returns a new `.loading` `RemoteData`.
  func testMapErrorLoading() {
    let sut = RemoteData<String, TestError>.loading
    let result = sut.mapError(g)

    switch result {
    case .loading: break
    case _: XCTFail("Expected error mapped RemoteData to be .success, got \(result)")
    }
  }

  /// `mapError`, when `self` is `.notAsked`, returns a new `.notAsked` `RemoteData`.
  func testMapErrorNotAsked() {
    let sut = RemoteData<String, TestError>.notAsked
    let result = sut.mapError(g)

    switch result {
    case .notAsked: break
    case _: XCTFail("Expected error mapped RemoteData to be .success, got \(result)")
    }
  }
}
