import XCTest
import RemoteData

struct TestError: Error, Equatable {
  let name: String

  static func == (lhs: TestError, rhs: TestError) -> Bool {
    return lhs.name == rhs.name
  }
}

struct OtherTestError: Error, Equatable {
  let number: Int

  static func == (lhs: OtherTestError, rhs: OtherTestError) -> Bool {
    return lhs.number == rhs.number
  }
}

class RemoteDataTests: XCTestCase {

  //
  // `map`
  //

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

  //
  // `mapError`
  //

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

  //
  // `mapBoth`
  //

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

  //
  // `init(value:)`
  //

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
