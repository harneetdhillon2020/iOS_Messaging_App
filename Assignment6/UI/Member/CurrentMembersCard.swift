
import SwiftUI

struct CurrentMembersCard: View {
  @EnvironmentObject var model: ViewModel
  
  var body: some View {
    List {
      if let members = model.selectedWorkspaceMembers {
        ForEach(members) { member in
          Text(member.name)
        }
        
        // Remove Member
        .onDelete { indexSet in
          let memberToDelete = model.selectedWorkspaceMembers![indexSet.first!].id
          model.deleteMember(memberID: memberToDelete.uuidString)
        }
      }
    }
    
    .onAppear {
      model.getMembersInWorkspace()
    }
    
    // Add Member
    .navigationBarItems(trailing:
                          NavigationLink(destination: AddMembersCard()) {
      Image(systemName: "plus.square")
        .foregroundColor(Color.blue)
        .accessibility(identifier: "Add Member")
    })
    .navigationBarTitle("Members", displayMode: .inline)
  }
}
