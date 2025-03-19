
import SwiftUI

struct WorkspacesCard: View {
  @State var disabled: Bool
  let workspace: Workspace
  
  var body: some View {
    NavigationLink(destination: ChannelsView(workspace: workspace)
      .navigationTitle(workspace.name)) {
        HStack() {
          Image(systemName: "person.3")
            .foregroundColor(Color.blue)
          Text(workspace.name)
            .accessibility(identifier: "\(workspace.name)")
          Spacer()
          if workspace.channels > 0 {
            Text(workspace.channels.description)
          }
        }
      }
      .deleteDisabled(disabled)
  }
}
