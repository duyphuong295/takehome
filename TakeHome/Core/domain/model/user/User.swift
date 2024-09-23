//
//  User.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation

// MARK: - Welcome
struct User: Codable {
  var id: Int?
  let login: String
  let avatarURL: URL?
  let htmlURL: URL?
  let location: String?
  let followers: Int?
  let following: Int?
  
  enum CodingKeys: String, CodingKey {
    case login, id
    case avatarURL = "avatar_url"
    case htmlURL = "html_url"
    case location
    case followers
    case following
  }
}

// MARK: - Identifiable
extension User: Identifiable, Equatable {
  static func == (lhs: User, rhs: User) -> Bool {
    lhs.id == rhs.id && lhs.login == rhs.login
  }
}
