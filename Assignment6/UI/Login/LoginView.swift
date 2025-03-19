
import SwiftUI

// Conditionally renders LoginScreen or WorkspacesScreen
// Got help from James TA for this

struct LoginView: View {
  @EnvironmentObject var model: ViewModel
  
  var body: some View {
    if (model.loginResponse != nil ){
      NavigationStack{
        WorkspacesView()
          .environmentObject(model)
      }
    } else {
      LoginCard()
        .environmentObject(model)
    }
  }
}
