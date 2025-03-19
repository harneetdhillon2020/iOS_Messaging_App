
import Foundation

struct SystemRepo {
  
  static func login(email: String, password: String) async throws -> LoginResponse {
    let url = URL(string: "https://cse118.com/api/v2/login")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(LoginCredentials(email: email, password: password))
    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode(LoginResponse.self, from: data)
  }
  
  static func reset(memberAccessToken: String) async throws {
    let url = URL(string: "https://cse118.com/api/v2/reset")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let (_, _) = try await URLSession.shared.data(for: request)
  }
}
