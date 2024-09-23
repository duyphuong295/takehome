//
//  ListUsersViewModelTests.swift
//  TakeHomeTests
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation
import XCTest
@testable import TakeHome

@MainActor
final class GithubUsersViewModelTests: XCTestCase {
  let testContext = PersistenceController.preview.container.viewContext
  // swiftlint:disable:next implicitly_unwrapped_optional
  var viewModel: GithubUsersViewModel!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    viewModel = GithubUsersViewModel(
      isLoading: true,
      userFetcher: UsersFetcherMock(),
      userStore: UserStoreService(context: testContext)
    )
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
    try super.tearDownWithError()
  }
  
  func testFetchUsersLoadingState() async {
    XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
    await viewModel.fetchUsers()
    XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading, but it is")
  }

  func testUpdatePageOnFetchMoreUsers() async {
    XCTAssertEqual(
      viewModel.since,
      1,
      "the view model's since property should be 1 before fetching, but it's \(viewModel.since)"
    )
    XCTAssertEqual(
      viewModel.perPage,
      20,
      "the view model's per page property should be 20 before fetching, but it's \(viewModel.since)"
    )
    await viewModel.fetchMoreUsers()
    XCTAssertEqual(
      viewModel.since,
      21,
      "the view model's since property should be 21 after fetching, but it's \(viewModel.since)"
    )
    XCTAssertEqual(
      viewModel.perPage,
      20,
      "the view model's per page property always should be 20 after fetching, but it's \(viewModel.since)"
    )
  }

  func testFetchUsersEmptyResponse() async {
    viewModel = GithubUsersViewModel(
      isLoading: true,
      userFetcher: EmptyResponseUsersFetcherMock(),
      userStore: UserStoreService(context: testContext)
    )
    await viewModel.fetchUsers()
    XCTAssertFalse(
      viewModel.hasMoreUsers,
      "hasMoreUsers should be false with an empty response, but it's true"
    )
    XCTAssertFalse(
      viewModel.isLoading,
      "the view model shouldn't be loading after receiving an empty response, but it is"
    )
  }
}

struct EmptyResponseUsersFetcherMock: UsersFetcher {
  func fetchUsers(since: Int, perPage: Int) async -> [User] {
    []
  }
  
  func fetchUserBy(name: String) async throws -> User {
    throw LoadMockUserError.invalidData
  }
}
