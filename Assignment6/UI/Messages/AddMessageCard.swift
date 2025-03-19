
import SwiftUI

struct AddMessageCard: View {
  @EnvironmentObject var model: ViewModel
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State private var messageText: String = ""
  
  var body: some View {
    VStack {
      TextEditor(text: $messageText)
        .border(Color.gray, width: 0.5)
        .frame(height: UIScreen.main.bounds.height / 4)
        .padding()
        .accessibilityLabel("Message")
      Spacer()
      
      HStack{
        Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }
        
        Button("OK") {
          model.addMessage(content: messageText)
          presentationMode.wrappedValue.dismiss()
        }
        .disabled(messageText.count < 1)
      }
      
      Spacer()
      
        .padding()
        .navigationTitle("New Message")
    }
  }
}
