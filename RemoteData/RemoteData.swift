public enum RemoteData<T, E: Error> {
  case notAsked
  case loading
  case failure(E)
  case success(T)
}

extension RemoteData {

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
}
