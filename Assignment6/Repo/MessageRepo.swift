
import Foundation

struct MessageRepo {
  
  static func get(memberAccessToken: String, id: String) async throws -> [Message] {
    let url = URL(string: "https://cse118.com/api/v2/channel/\(id)/message")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let (data, _) = try await URLSession.shared.data(for: request)
    let decoder = JSONDecoder.javaScriptISO8601()
    return try decoder.decode([Message].self, from: data).reversed()
  }
  
  static func add(memberAccessToken: String, id: String, content: String) async throws  {
    let url = URL(string: "https://cse118.com/api/v2/channel/\(id)/message")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    request.httpBody = try JSONEncoder().encode(NewMessage(content: content))
    let _ = try await URLSession.shared.data(for: request)
  }
  
  static func delete(memberAccessToken: String, id: String) async throws  {
    let url = URL(string: "https://cse118.com/api/v2/message/\(id)")!
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let _ = try await URLSession.shared.data(for: request)
  }
  
}

