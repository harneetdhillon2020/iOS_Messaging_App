
import SwiftUI

/*
 Sources:
  https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-view-dismiss-itself
 */

struct AddMembersCard: View {
  @EnvironmentObject var model: ViewModel
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    List {
      ForEach(model.member) { member in
        if (!model.selectedWorkspaceMembers!.contains(where: {$0.id.uuidString == member.id.uuidString}))
            && (model.selectedWorkspace!.owner != member.id.uuidString.lowercased())  {
          Text(member.name)
            .swipeActions {
              Button() {
                model.addMember(memberID: member.id.uuidString)
                presentationMode.wrappedValue.dismiss()
              } label: {
                VStack{
                  Image(systemName: "person.fill.badge.plus")
                    .foregroundColor(.green)
                }
              }
              .tint(.green)
              .accessibilityLabel("Add")
            }
        }
      }
    }
    .navigationBarTitle("Members", displayMode: .inline)
  }
}
