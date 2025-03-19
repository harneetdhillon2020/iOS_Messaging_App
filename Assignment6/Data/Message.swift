
import Foundation

struct Message: Identifiable, Decodable {
  let id: UUID
  let member: String
  let posted: Date
  let content: String
}
