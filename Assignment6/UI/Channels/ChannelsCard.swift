
import SwiftUI

struct ChannelsCard: View {
  @EnvironmentObject var model: ViewModel
  @State var disabled: Bool
  let channel: Channel
  
  var body: some View {
    NavigationLink(destination: MessagesView(channel: channel)
      .navigationTitle(channel.name)) {
      HStack() {
        Text(channel.name)
        Spacer()
        if channel.messages > 0 {
          Text(channel.messages.description)
        }
      }
    }
    .deleteDisabled(disabled)
  }
}
