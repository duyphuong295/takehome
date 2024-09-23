//
//  UsersFetcherMock.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation

struct UsersFetcherMock: UsersFetcher {
  func fetchUsers(since: Int, perPage: Int) async -> [User] {
    User.mock
  }
  
  func fetchUserBy(name: String) async throws -> User {
    try User.mockUser()
  }
}
