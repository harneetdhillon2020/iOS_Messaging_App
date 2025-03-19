
import Foundation

struct LoginResponse: Codable, Identifiable {
  let id: String
  let role: String
  let name: String
  let accessToken: String
}
