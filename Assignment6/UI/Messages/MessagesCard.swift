
import SwiftUI

struct MessagesCard: View {
  @EnvironmentObject var model: ViewModel
  @State var disabled: Bool
  let message: Message
  
  // Chat GPT Inspired
  func getMemberById(id: String, member: [Member]) -> Member? {
      return member.first { $0.id.uuidString.uppercased() == id.uppercased() }
  }
  
  // Chat GPT Inspired
  private func formatDate(date: Date) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
      return dateFormatter.string(from: date)
  }
  
  var body: some View {
    VStack() {
      Text(getMemberById(id: message.member, member: model.member)!.name)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
      Text(message.content)
        .frame(maxWidth: .infinity, alignment: .leading)
      Text(formatDate(date: message.posted))
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    .deleteDisabled(disabled)
  }
}
