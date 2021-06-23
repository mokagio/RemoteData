import RemoteData
import SwiftUI

struct ContentView: View {
  let remoteData: RemoteData<String, Error> =
    .success("Hello, world!")
//    .failure(SampleError())
//    .notAsked
//    .loading

  var body: some View {
    switch remoteData {
    case .success(let value):
      Text(value).padding()
    case .loading:
      Text("Loading...").padding()
    case .notAsked:
      Text("Not asked...").padding()
    case .failure(let error):
      Text(error.localizedDescription).padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct SampleError: Error {}
