
import SwiftUI

//James TA helped me with this

@main
struct Assignment6App: App {
  var body: some Scene {
    WindowGroup {
      LoginView()
        .environmentObject(ViewModel())
    }
  }
}
