public enum RemoteData<T, E: Error> {
  case notAsked
  case loading
  case failure(E)
  case success(T)
}

extension RemoteData {

  public init(value: T) {
    self = .success(value)
  }

  public func map<U>(_ transform: (T) -> U) -> RemoteData<U, E> {
    switch self {
    case .success(let value): return .success(transform(value))
    case .failure(let error): return .failure(error)
    case .loading: return .loading
    case .notAsked: return .notAsked
    }
  }

  public func mapError<F: Error>(_ transform: (E) -> F) -> RemoteData<T, F> {
    switch self {
    case .success(let value): return .success(value)
    case .failure(let error): return .failure(transform(error))
    case .loading: return .loading
    case .notAsked: return .notAsked
    }
  }

  public func mapBoth<U, F: Error>(transformValue: (T) -> U, transformError: (E) -> F) -> RemoteData<U, F> {
    switch self {
    case .failure(let error): return .failure(transformError(error))
    case .success(let value): return .success(transformValue(value))
    case .loading: return .loading
    case .notAsked: return .notAsked
    }
  }

  /// Returns the success value as a throwing expression.
  ///
  /// Use this method to retrieve the value of this remote data if it represents a
  /// success, or to catch the value otherwise.
  ///
  ///     let integerRemoteData: RemoteData<Int, Error> = .success(5)
  ///     do {
  ///       let value = try integerRemoteData.get()
  ///       print("The value is \(value).")
  ///     } catch {
  ///       print("Error retrieving the value: \(error)")
  ///     }
  ///     // Prints "The value is 5."
  ///
  /// - Returns: The success value, if the instance represents a success.
  /// - Throws: The failure value, if the instance does not represents a success.
  @inlinable public func get() throws -> T {
    switch self {
    case .success(let value): return value
    case .failure(let error): throw error
    case _: throw GetError()
    }
  }

  @usableFromInline
  struct GetError: Error {

    @usableFromInline init() {}
  }
}
