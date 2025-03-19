

import SwiftUI

struct MessagesView: View {
  @EnvironmentObject var model: ViewModel
  let channel: Channel
  
  var body: some View {
    List {
      ForEach(model.messages) { message in
        if (message.member == model.loginResponse!.id) || (model.loginResponse!.id == model.selectedWorkspace!.owner) {
          MessagesCard(disabled:false, message:message)
            .swipeActions {
              Button() {
                model.deleteMessage(id: message.id.uuidString)
              } label: {
                VStack{
                  Image(systemName: "trash")
                    .foregroundColor(.red)
                  Text("Delete")
                }
              }
              .tint(.red)
              .accessibilityLabel("Delete")
            }
        } else {
          MessagesCard(disabled:true, message:message)
        }
      }
      
    }
    .onAppear {
      model.getMessages(id: channel.id.uuidString)
      model.selectedChannel = channel
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(destination: AddMessageCard()) {
          Image(systemName: "plus.square")
            .foregroundColor(Color.blue)
        }
        .accessibilityLabel("New Message")
      }
    }
  }
}
