
import Foundation

struct Workspace: Identifiable, Decodable {
  let id: UUID
  let name: String
  let owner: String
  let channels: Int
}
