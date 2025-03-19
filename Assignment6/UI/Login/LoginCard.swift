
import SwiftUI

struct LoginCard: View {
  @EnvironmentObject var model: ViewModel
  @State private var username: String = ""
  @State private var password: String = ""
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        
        Text("CSE118 Assignment 6")
        
        Image("SlugLogo")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 150, height: 150)
          .clipped()
        
        TextField("EMail", text: $username)
          .padding()
          .frame(width: 300, height: 40)
          .background(Color.black.opacity(0.05))
          .autocapitalization(.none)
        
        SecureField("Password", text: $password)
          .padding()
          .frame(width: 300, height: 40)
          .background(Color.black.opacity(0.05))
        
        Button("Login") {
          model.login(username: username, password: password)
        }
        .padding()
        .frame(width: 300, height: 40)
        .foregroundColor(Color.white)
        .background(Color.blue)
        
        Spacer()
        Spacer()
      }
      
      .padding()
    }
  }
}
