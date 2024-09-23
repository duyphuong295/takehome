//
//  FetchUsersService.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation

actor FetchUsersService {
  private let requestManager: RequestManagerProtocol
  
  init(requestManager: RequestManagerProtocol) {
    self.requestManager = requestManager
  }
}

// MARK: - UsersFetcher
extension FetchUsersService: UsersFetcher {
  func fetchUsers(since: Int, perPage: Int) async -> [User] {
    let requestData = UsersRequest.getUsersWith(since: since, perPage: perPage)
    do {
      let users: [User] = try await requestManager.initRequest(with: requestData)
      return users
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func fetchUserBy(name: String) async throws -> User {
    let requestData = UsersRequest.getUserBy(name: name)
    let user: User = try await requestManager.initRequest(with: requestData)
    return user
  }
}
