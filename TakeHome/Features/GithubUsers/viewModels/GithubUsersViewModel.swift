//
//  ListUsersViewModel.swift
//  TakeHome
//
//  Created by Duy Phuong on 19/09/2024.
//

import Foundation

protocol UsersFetcher {
  func fetchUsers(since: Int, perPage: Int) async -> [User]
  func fetchUserBy(name: String) async throws -> User
}

protocol UsersStore {
  func save(users: [User]) async throws
}

@MainActor
final class GithubUsersViewModel: ObservableObject {
  @Published var isLoading: Bool
  @Published var hasMoreUsers = true
  private let userFetcher: UsersFetcher
  private let userStore: UsersStore
  
  private(set) var since = 1
  private(set) var perPage = 20
  
  init(isLoading: Bool = true,
       userFetcher: UsersFetcher,
       userStore: UsersStore) {
    self.isLoading = isLoading
    self.userFetcher = userFetcher
    self.userStore = userStore
  }
  
  func fetchUsers() async {
    isLoading = true
    do {
      let users = await userFetcher.fetchUsers(since: since, perPage: perPage)
      try await userStore.save(users: users)
      hasMoreUsers = users.isNotEmpty
    } catch {
      print("Error fetching users... \(error.localizedDescription)")
    }
    isLoading = false
  }
  
  func fetchMoreUsers() async {
    since += perPage
    await fetchUsers()
  }
}
