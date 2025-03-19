
import SwiftUI

struct WorkspacesView: View {
  @EnvironmentObject var model: ViewModel
  
  var body: some View {
    List {
      if let id = model.loginResponse?.id {
        ForEach(model.workspaces) { workspace in
          if (workspace.owner == id) {
            WorkspacesCard(disabled:false, workspace: workspace)
          } else {
            WorkspacesCard(disabled:true, workspace: workspace)
          }
        }
        
        // Delete Workspace
        .onDelete { indexSet in
          let workspaceIDToDelete = model.workspaces[indexSet.first!].id
          model.deleteWorkspace(id: workspaceIDToDelete.uuidString)
        }
      }
    }
    
    .onAppear {
      model.getWorkspaces()
      model.getMembers()
    }
    
    // Title
    .navigationBarTitle("Workspaces", displayMode: .inline)
    
    // Logout Button
    .navigationBarItems(leading:
                          Button(action: { model.loginResponse = nil }) {
      Image(systemName: "rectangle.portrait.and.arrow.right")
        .foregroundColor(Color.blue)
        .accessibility(identifier: "Logout")
    })
    
    // Add Workspace Button
    .navigationBarItems(trailing:
                          NavigationLink(destination: AddWorkspaceCard()) {
      Image(systemName: "plus.square")
        .foregroundColor(Color.blue)
        .accessibility(identifier: "New Workspace")
    })
    
    // Reset Button
    .navigationBarItems(trailing:
                          Button(action: {model.reset()}) {
      Image(systemName: "arrow.uturn.left.circle")
        .foregroundColor(Color.blue)
        .accessibility(identifier: "Reset")
    })
    
  }
}
