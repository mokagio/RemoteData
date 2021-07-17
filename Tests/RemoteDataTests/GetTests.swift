import XCTest
import RemoteData

class GetTests: XCTestCase {

  /// `get`, when `self` is `.failure`, throws.
  func testGetFailure() {
    let error = TestError(name: "foo")
    let sut = RemoteData<String, TestError>.failure(error)
    XCTAssertThrowsError(try sut.get())
  }

  /// `get`, when `self` is `.success`, returns the wrapped value.
  func testGetSuccess() {
    let sut = RemoteData<String, TestError>.success("value")
    XCTAssertEqual(try sut.get(), "value")
  }

  /// `get`, when `self` is `.loading`, throws.
  func testGetLoading() {
    XCTAssertThrowsError(try RemoteData<String, TestError>.loading.get())
  }

  /// `get`, when `self` is `.notAsked`, throws.
  func testGetNotAsked() {
    XCTAssertThrowsError(try RemoteData<String, TestError>.notAsked.get())
  }
}
