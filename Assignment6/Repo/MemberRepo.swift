
import Foundation

struct MemberRepo {
  
  static func getAllMembers(accessToken: String) async throws -> [Member] {
    let url = URL(string: "https://cse118.com/api/v2/member")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode([Member].self, from: data)
  }
  
  static func getMembersInWorkspace(accessToken: String, workspaceID: String) async throws -> [Member] {
    let url = URL(string: "https://cse118.com/api/v2/workspace/\(workspaceID.lowercased())/member")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode([Member].self, from: data)
  }
  
  
  static func add(memberAccessToken: String, workspaceID: String, memberID: String) async throws  {
    var url = URLComponents(string: "https://cse118.com/api/v2/workspace/\(workspaceID)/member")!
    url.queryItems = [ URLQueryItem(name: "mid", value: memberID) ]
    var request = URLRequest(url: url.url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let _ = try await URLSession.shared.data(for: request)
  }
  
  static func delete(memberAccessToken: String, workspaceID: String, memberID: String) async throws  {
    var url = URLComponents(string: "https://cse118.com/api/v2/workspace/\(workspaceID)/member")!
    url.queryItems = [ URLQueryItem(name: "mid", value: memberID) ]
    var request = URLRequest(url: url.url!)
    request.httpMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let _ = try await URLSession.shared.data(for: request)
  }
  
}

