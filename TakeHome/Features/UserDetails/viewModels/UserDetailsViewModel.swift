//
//  UserDetailsViewModel.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation
import CoreData

@MainActor
final class UserDetailsViewModel: ObservableObject {
  @Published var isLoading: Bool
  @Published private(set) var userEntity: UserEntity
  private(set) var user: User?
  private let userFetcher: UsersFetcher
  private let userStore: UsersStore
  
  init(userEntity: UserEntity,
       isLoading: Bool = true,
       userFetcher: UsersFetcher,
       userStore: UsersStore) {
    self.userEntity = userEntity
    self.isLoading = isLoading
    self.userFetcher = userFetcher
    self.userStore = userStore
  }
  
  func fetchUserDetails() async {
    guard let name = userEntity.login,
          name.isNotEmpty else { return }
    isLoading = true
    do {
      let user = try await userFetcher.fetchUserBy(name: name)
      self.user = user
      try await userStore.save(users: [user])
      fetchUserFromCoreData()
    } catch {
      print("Error fetching users... \(error.localizedDescription)")
    }
    isLoading = false
  }
  
  func fetchUserFromCoreData() {
    guard let name = userEntity.login,
          name.isNotEmpty else { return }
    let fetchRequest = UserEntity.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "login == %@", name)
    let context = PersistenceController.shared.container.viewContext
    if let results = try? context.fetch(fetchRequest),
       let userEntity = results.first {
      self.userEntity = userEntity
    }
  }
}
