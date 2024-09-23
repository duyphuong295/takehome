//
//  User+CoreData.swift
//  TakeHome
//
//  Created by Duy Phuong on 20/09/2024.
//

import CoreData

// MARK: - UserEntity Properties
extension UserEntity {
  
}

// MARK: - UUIDIdentifiable
extension User: UUIDIdentifiable {
  init(managedObject: UserEntity) {
    self.id = Int(managedObject.id)
    self.login = managedObject.login ?? "No Name"
    self.avatarURL = managedObject.avatarURL
    self.htmlURL = managedObject.htmlURL
    self.location = managedObject.location
    self.followers = Int(managedObject.followers)
    self.following = Int(managedObject.following)
  }
  
  private func checkForExistingUser(id: Int, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Bool {
    let fetchRequest = UserEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id = %d", id)
    if let results = try? context.fetch(fetchRequest), let user = results.first {
      updateEntity(user: user, context: context)
      return true
    }
    return false
  }
  
  mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    guard let id else { return }
    guard checkForExistingUser(id: id, context: context) == false else { return }
    let persistedValue = UserEntity.init(context: context)
    persistedValue.id = Int64(id)
    persistedValue.login = self.login
    persistedValue.avatarURL = self.avatarURL
    persistedValue.htmlURL = self.htmlURL
    persistedValue.location = self.location
    persistedValue.followers = Int64(self.followers ?? 0)
    persistedValue.following = Int64(self.following ?? 0)
  }
  
  private func updateEntity(user: UserEntity, context: NSManagedObjectContext) {
    user.login = login
    user.avatarURL = avatarURL
    user.htmlURL = htmlURL
    user.location = location
    user.followers = Int64(followers ?? 0)
    user.following = Int64(following ?? 0)
  }
}
