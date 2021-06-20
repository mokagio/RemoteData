@testable import RemoteData
import XCTest

class MapBothTests: XCTestCase {

  /// `mapBoth`, when `self` is `.failure`, returns a new `.failure` `RemoteData` with associated
  /// value the result of the given `transformError` with input the associated value of `self`.
  func testMapBothFailure() {
    let sut = RemoteData<String, TestError>.failure(TestError(name: "test"))
    let result = sut.mapBoth(
      transformValue: { "\($0)\($0)" },
      transformError: { _ in return TestError(name: "transformed")}
    )

    switch result {
    case .failure(let resultError): XCTAssertEqual(resultError, TestError(name: "transformed"))
    case _: XCTFail("Expected RemotedData to be .failure, got \(result)")
    }
  }

  /// `mapBoth`, when `self` is `.success`, returns a new `.success` `RemoteData` with associated
  /// value the result of the given `transformValue` with input the associated value of `self`.
  func testMapBothSuccess() {
    let sut = RemoteData<String, TestError>.success("abc")
    let result = sut.mapBoth(
      transformValue: { "\($0)\($0)" },
      transformError: { $0 }
    )

    switch result {
    case .success(let value): XCTAssertEqual(value, "abcabc")
    case _: XCTFail("Expected RemoteData to be .success, got \(result)")
    }
  }

  /// `mapBoth`, when `self` is `.loading`, returns a new `.loading` `RemoteData`.
  func testMapBothLoading() {
    let sut = RemoteData<String, TestError>.loading
    let result = sut.mapBoth(transformValue: { $0 }, transformError: { $0 })

    switch result {
    case .loading: break
    case _: XCTFail("Expected RemoteData to be .success, got \(result)")
    }
  }

  /// `mapBoth`, when `self` is `.notAsked`, returns a new `.notAsked` `RemoteData`.
  func testMapBothNotAsked() {
    let sut = RemoteData<String, TestError>.notAsked
    let result = sut.mapBoth(transformValue: { $0 }, transformError: { $0 })

    switch result {
    case .notAsked: break
    case _: XCTFail("Expected RemoteData to be .success, got \(result)")
    }
  }
}
