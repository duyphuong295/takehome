//
//  UserMock.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation

public enum LoadMockUserError: LocalizedError {
  case invalidURL
  case invalidData
  public var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "URL string is malformed."
    case .invalidData:
      return "The data returned an invalid response."
    }
  }
}

// MARK: - Mock data
extension User {
  static let mock = loadUsers()
  static func mockUser() throws -> User {
    try loadUser()
  }
}

private func loadUsers() -> [User] {
  guard let url = Bundle.main.url(forResource: "UsersMock", withExtension: "json"),
        let data = try? Data(contentsOf: url) else { return [] }
  let decoder = JSONDecoder()
  let usersMock = try? decoder.decode([User].self, from: data)
  return usersMock ?? []
}

private func loadUser() throws -> User {
  guard let url = Bundle.main.url(forResource: "SingleUserMock", withExtension: "json") else {
    throw LoadMockUserError.invalidURL
  }
  guard let data = try? Data(contentsOf: url) else {
    throw LoadMockUserError.invalidData
  }
  let decoder = JSONDecoder()
  let userMock = try decoder.decode(User.self, from: data)
  return userMock
}
