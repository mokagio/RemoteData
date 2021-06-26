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
