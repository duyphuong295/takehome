//
//  CoreDataTests.swift
//  TakeHomeTests
//
//  Created by Duy Phuong on 21/09/2024.
//

import XCTest
@testable import TakeHome
import CoreData

final class CoreDataTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }
  
  func testToManagedObject() throws {
    let previewContext = PersistenceController.preview.container.viewContext
    let fetchRequest = UserEntity.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \UserEntity.login, ascending: true)]
    guard let results = try? previewContext.fetch(fetchRequest),
          let first = results.first else { return }
    
    XCTAssert(first.login == "anotherjesse", """
        User name did not match, was expecting anotherjesse, got
        \(String(describing: first.login))
      """)
    XCTAssert(first.avatarURL?.absoluteString == "https://avatars.githubusercontent.com/u/27?v=4", """
        User avatar url did not match, was expecting "https://avatars.githubusercontent.com/u/27?v=4", got
        \(String(describing: first.avatarURL?.absoluteString))
      """)
    XCTAssert(first.htmlURL?.absoluteString == "https://github.com/anotherjesse", """
        User html url did not match, was expecting "https://github.com/anotherjesse", got
        \(String(describing: first.htmlURL?.absoluteString))
      """)
  }
  
  func testDeleteManagedObject() throws {
    let previewContext = PersistenceController.preview.container.viewContext
    
    let fetchRequest = UserEntity.fetchRequest()
    guard let results = try? previewContext.fetch(fetchRequest),
          let first = results.first else { return }
    
    previewContext.delete(first)
    
    guard let results = try? previewContext.fetch(fetchRequest)
    else { return }
    
    XCTAssert(results.count == 19, """
      The number of results was expected to be 19 after deletion, was \(results.count)
    """)
  }
  
  func testFetchManagedObject() throws {
    let previewContext = PersistenceController.preview.container.viewContext
    let fetchRequest = UserEntity.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "login == %@", "tomtt")
    guard let results = try? previewContext.fetch(fetchRequest),
          let first = results.first else { return }
    XCTAssert(first.login == "tomtt", """
      User name did not match, expecting tomtt, got
      \(String(describing: first.login))
    """)
  }
}
