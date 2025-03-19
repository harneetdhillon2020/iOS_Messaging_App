
import SwiftUI

struct AddChannelCard: View {
  @EnvironmentObject var model: ViewModel
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State private var channelText: String = ""
  
  var body: some View {
    VStack {
      Spacer()
        .frame(height: UIScreen.main.bounds.height / 8)
      TextField("Name", text: $channelText)
        .padding()
      Spacer()
      
      HStack{
        Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }
        
        Button("OK") {
          model.addChannel(workspaceID: model.selectedWorkspace!.id.uuidString, name: channelText)
          presentationMode.wrappedValue.dismiss()
        }
        .disabled(channelText.count < 4)
      }
      
      Spacer()
      
        .padding()
        .navigationTitle("New Channel")
    }
  }
}
