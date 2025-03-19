
import Foundation

struct Channel: Identifiable, Decodable {
  let id: UUID
  let name: String
  let messages: Int
}
