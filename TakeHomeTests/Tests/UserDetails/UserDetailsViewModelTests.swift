//
//  UserDetailsViewModelTests.swift
//  TakeHomeTests
//
//  Created by Duy Phuong on 21/09/2024.
//

import XCTest
@testable import TakeHome

@MainActor
final class UserDetailsViewModelTests: XCTestCase {
  let testContext = PersistenceController.preview.container.viewContext
  // swiftlint:disable:next implicitly_unwrapped_optional
  var viewModel: UserDetailsViewModel!
  var userEntity: UserEntity!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    if let userEntity = CoreDataHelper.getTestUserEntity() {
      self.userEntity = userEntity
      viewModel = UserDetailsViewModel(
        userEntity: userEntity,
        userFetcher: UsersFetcherMock(),
        userStore: UserStoreService(context: testContext)
      )
    }
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
    try super.tearDownWithError()
  }
  
  func testInitializeSut() {
    XCTAssertNotNil(
      viewModel,
      "Sut should be existing, but it is nil"
    )
    XCTAssertEqual(viewModel.user, nil)
    XCTAssertNotNil(viewModel.userEntity.login)
    XCTAssertTrue(viewModel.isLoading)
  }
  
  func testFetchUserDetailsLoadingState() async {
    XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
    await viewModel.fetchUserDetails()
    XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading, but it is")
  }
  
  func testFetchUserDetailsSuccess() async throws {
    await viewModel.fetchUserDetails()
    XCTAssertNotNil(
      viewModel.userEntity,
      "user details should be existing, but it's nil"
    )
    XCTAssertFalse(
      viewModel.isLoading,
      "the view model shouldn't be loading after receiving an error response, but it is"
    )
  }
  
  func testFetchUserDetailsFailedResponse() async throws {
    viewModel = UserDetailsViewModel(
      userEntity: userEntity,
      isLoading: true,
      userFetcher: EmptyResponseUsersFetcherMock(),
      userStore: UserStoreService(context: testContext)
    )
    
    await viewModel.fetchUserDetails()
    XCTAssertNil(
      viewModel.user,
      "user details should be nil with an error response, but it's exist"
    )
    XCTAssertFalse(
      viewModel.isLoading,
      "the view model shouldn't be loading after receiving an error response, but it is"
    )
  }
}
