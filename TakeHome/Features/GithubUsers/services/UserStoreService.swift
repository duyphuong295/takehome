//
//  UserStoreService.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation
import CoreData

actor UserStoreService {
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.context = context
  }
}

// MARK: - UserStore
extension UserStoreService: UsersStore {
  func save(users: [User]) async throws {
    for var user in users {
      user.toManagedObject(context: context)
    }
    try context.save()
  }
}
