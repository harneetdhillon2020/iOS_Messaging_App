
import SwiftUI

/*
 Sources:
  https://www.hackingwithswift.com/books/ios-swiftui/deleting-items-using-ondelete
 */

struct ChannelsView: View {
  @EnvironmentObject var model: ViewModel
  let workspace: Workspace
  
  
  var body: some View {
    List {
      ForEach(model.channels) { channel in
        if (workspace.owner == model.loginResponse!.id) {
          ChannelsCard(disabled:false, channel: channel)
            .accessibilityLabel("\(channel.name)")
        }
        else{
          ChannelsCard(disabled:true, channel: channel)
            .accessibilityLabel("\(channel.name)")
        }
      }
      
      // Delete Channel Swipe
      .onDelete { indexSet in
        let channelIDToDelete = model.channels[indexSet.first!].id
        model.deleteChannel(id: channelIDToDelete.uuidString)
      }
    }
    
    .onAppear {
      model.getChannels(id: workspace.id.uuidString)
      model.selectedWorkspace = workspace
    }
    
    // Add Channel Button
    .navigationBarItems(trailing:
                          Group {
      if (workspace.owner == model.loginResponse!.id) {
        NavigationLink(destination: AddChannelCard()) {
          Image(systemName: "plus.square")
            .foregroundColor(Color.blue)
            .accessibility(identifier: "New Channel")
        }
      }
    })
    
    // Add Member Button
    .navigationBarItems(trailing:
                          Group {
      if workspace.owner == model.loginResponse?.id {
        NavigationLink(destination: CurrentMembersCard()) {
          Image(systemName: "person.badge.plus")
            .foregroundColor(Color.blue)
            .accessibility(identifier: "Add Members")
        }
      }
    })
  }
}
