
import Foundation

class ViewModel: ObservableObject {
  @Published var loginResponse : LoginResponse? = nil
  @Published var workspaces = [Workspace]()
  @Published var channels = [Channel]()
  @Published var messages = [Message]()
  @Published var member = [Member]()
  @Published var selectedWorkspace : Workspace? = nil
  @Published var selectedWorkspaceMembers : [Member]? = nil
  @Published var selectedChannel : Channel? = nil
  
  
  func login(username: String, password: String) {
    Task {
      do {
        let response = try await SystemRepo.login(email: username, password: password)
        DispatchQueue.main.async {
          self.loginResponse = response
        }
      }
      catch {
        DispatchQueue.main.async {
          print("Invalid login credentials")
        }
      }
    }
  }
  
  // ######################################################################  GETS ####################################################################
  
  func getWorkspaces() {
    Task {
      let loaded = try! await WorkspaceRepo.get(memberAccessToken: loginResponse!.accessToken)
      DispatchQueue.main.async {
        self.workspaces = loaded
      }
    }
  }
  
  func getChannels(id: String) {
    Task {
      let loaded = try! await ChannelRepo.get(memberAccessToken: loginResponse!.accessToken, id: id )
      DispatchQueue.main.async {
        self.channels = loaded
      }
    }
  }
  
  func getMessages(id: String) {
    Task {
      do {
        let loaded = try! await MessageRepo.get(memberAccessToken: loginResponse!.accessToken, id: id)
        DispatchQueue.main.async {
          self.messages = loaded
        }
      }
    }
  }
  
  func getMembers() {
    Task {
      do {
        let loaded = try! await MemberRepo.getAllMembers(accessToken: loginResponse!.accessToken)
        DispatchQueue.main.async {
          self.member = loaded
        }
      }
    }
  }
  
  func getMembersInWorkspace() {
    Task {
      do {
        let loaded = try! await MemberRepo.getMembersInWorkspace(accessToken: loginResponse!.accessToken, workspaceID: selectedWorkspace!.id.uuidString)
        DispatchQueue.main.async {
          self.selectedWorkspaceMembers = loaded
        }
      }
    }
  }
  
  // ######################################################################  ADD ##################################################################
  
  func addMessage(content: String) {
    Task {
      try await MessageRepo.add(memberAccessToken: loginResponse!.accessToken, id: selectedChannel!.id.uuidString, content: content )
    }
  }
  
  func addWorkspace(name: String) {
    Task {
      try await WorkspaceRepo.add(memberAccessToken: loginResponse!.accessToken, name)
    }
  }
  
  func addChannel(workspaceID: String, name: String) {
    Task {
      try await ChannelRepo.add(workspaceID: workspaceID, memberAccessToken: loginResponse!.accessToken, name)
    }
  }
  
  func addMember(memberID: String) {
    Task {
      try await MemberRepo.add(memberAccessToken: loginResponse!.accessToken, workspaceID: selectedWorkspace!.id.uuidString, memberID: memberID)
    }
  }
  
  // ######################################################################  DELETE #################################################################
  
  func deleteMessage(id: String) {
    Task {
      try await MessageRepo.delete(memberAccessToken: loginResponse!.accessToken, id: id)
    }
    messages.removeAll(where: {$0.id.uuidString == id})
  }
  
  func deleteWorkspace(id: String) {
    Task {
      try await WorkspaceRepo.delete(memberAccessToken: loginResponse!.accessToken, id: id)
    }
  }
  
  func deleteChannel(id: String) {
    Task {
      try await ChannelRepo.delete(memberAccessToken: loginResponse!.accessToken, id: id)
    }
  }
  
  func deleteMember(memberID: String) {
    Task {
      try await MemberRepo.delete(memberAccessToken: loginResponse!.accessToken, workspaceID: selectedWorkspace!.id.uuidString, memberID: memberID)
    }
  }
  
  // ######################################################################  Reset ##################################################################
  
  func reset() {
    workspaces = [Workspace]()
    Task {
      try await SystemRepo.reset(memberAccessToken: loginResponse!.accessToken)
      let loaded = try! await WorkspaceRepo.get(memberAccessToken: loginResponse!.accessToken)
      DispatchQueue.main.async {
        self.workspaces = loaded
      }
    }
  }
}
