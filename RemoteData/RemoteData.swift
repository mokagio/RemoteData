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
}
