
import SwiftUI

struct AddWorkspaceCard: View {
  @EnvironmentObject var model: ViewModel
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State private var workspaceText: String = ""
  
  var body: some View {
    VStack {
      
      Spacer()
        .frame(height: UIScreen.main.bounds.height / 8)
      TextField("Name", text: $workspaceText)
        .padding()
      Spacer()
      
      HStack{
        Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }
        Button("OK") {
          model.addWorkspace(name: workspaceText)
          presentationMode.wrappedValue.dismiss()
        }
        .disabled(workspaceText.count < 4)
      }
      
      Spacer()
      
        .padding()
        .navigationTitle("New Workspace")
    }
  }
}
