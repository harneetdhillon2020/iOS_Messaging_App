
import Foundation

struct WorkspaceRepo {
  
  static func get(memberAccessToken: String) async throws -> [Workspace] {
    let url = URL(string: "https://cse118.com/api/v2/workspace")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode([Workspace].self, from: data)
  }
  
  static func delete(memberAccessToken: String, id: String) async throws {
    let url = URL(string: "https://cse118.com/api/v2/workspace/\(id)")!
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    let (_, _) = try await URLSession.shared.data(for: request)
  }
  
  static func add(memberAccessToken: String, _ workspaceName: String) async throws {
    let url = URL(string: "https://cse118.com/api/v2/workspace")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(memberAccessToken)", forHTTPHeaderField: "Authorization")
    request.httpBody = try JSONEncoder().encode(NewWorkspace(name: workspaceName))
    let (_, _) = try await URLSession.shared.data(for: request)
  }
  
}

