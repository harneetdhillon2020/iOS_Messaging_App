
import Foundation

struct ChannelRepo {
  
  static func get(memberAccessToken: String, id: String) async throws -> [Channel] {
    let url = URL(string: "https://cse118.com/api/v2/workspace/\(id.lowercased())/channel")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode([Channel].self, from: data)
  }
  
  static func delete(memberAccessToken: String, id: String) async throws {
    let url = URL(string: "https://cse118.com/api/v2/channel/\(id)")!
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let (_, _) = try await URLSession.shared.data(for: request)
  }
  
  static func add(workspaceID: String, memberAccessToken: String, _ channelName: String) async throws {
    let url = URL(string: "https://cse118.com/api/v2/workspace/\(workspaceID)/channel")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    request.httpBody = try JSONEncoder().encode(NewChannel(name: channelName))
    let (_, _) = try await URLSession.shared.data(for: request)
  }
}
