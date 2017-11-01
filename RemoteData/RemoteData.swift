public enum RemoteData<T, E: Error> {
  case notAsked
  case loading
  case failure(E)
  case success(T)
}
