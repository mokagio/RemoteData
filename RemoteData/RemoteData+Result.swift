extension RemoteData {

  public init(_ result: Result<T, E>) {
    switch result {
    case .success(let value): self = .success(value)
    case .failure(let error): self = .failure(error)
    }
  }
}
