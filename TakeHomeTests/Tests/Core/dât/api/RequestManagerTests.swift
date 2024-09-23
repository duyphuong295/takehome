//
//  RequestManagerTests.swift
//  TakeHomeTests
//
//  Created by Duy Phuong on 21/09/2024.
//

import XCTest
@testable import TakeHome

final class RequestManagerTests: XCTestCase {
  private var requestManager: RequestManagerProtocol?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    requestManager = RequestManagerMock(apiManager: APIManagerMock())
  }
  
  override func tearDownWithError() throws {
    requestManager = nil
    try super.tearDownWithError()
  }
  
  func testRequestUsers() async throws {
    guard let users: [User] = try await requestManager?.initRequest(with: UsersRequestMock.getUsers) else { return }
    let first = users.first
    let last = users.last
    XCTAssertEqual(first?.login, "defunkt")
    XCTAssertEqual(first?.avatarURL?.absoluteString, "https://avatars.githubusercontent.com/u/2?v=4")
    XCTAssertEqual(first?.htmlURL?.absoluteString, "https://github.com/defunkt")
    XCTAssertEqual(first?.location, nil)
    XCTAssertEqual(first?.followers, nil)
    XCTAssertEqual(first?.following, nil)
    
    XCTAssertEqual(last?.login, "tomtt")
    XCTAssertEqual(last?.avatarURL?.absoluteString, "https://avatars.githubusercontent.com/u/31?v=4")
    XCTAssertEqual(last?.htmlURL?.absoluteString, "https://github.com/tomtt")
    XCTAssertEqual(last?.location, nil)
    XCTAssertEqual(last?.followers, nil)
    XCTAssertEqual(last?.following, nil)
  }
  
  func testRequestUserByName() async throws {
    guard let user: User = try await requestManager?.initRequest(with: UsersRequestMock.getUserByName) else { return }
    XCTAssertEqual(user.login, "ezmobius")
    XCTAssertEqual(user.avatarURL?.absoluteString, "https://avatars.githubusercontent.com/u/5?v=4")
    XCTAssertEqual(user.htmlURL?.absoluteString, "https://github.com/ezmobius")
    XCTAssertEqual(user.location, "In the NW")
    XCTAssertEqual(user.followers, 558)
    XCTAssertEqual(user.following, 13)
  }
}
