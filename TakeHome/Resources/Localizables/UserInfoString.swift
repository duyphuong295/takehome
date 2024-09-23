//
//  ListUserString.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation

protocol LocalizedString {
  var localized: String { get }
}

enum UserInfoString: String, LocalizedString {
  case githubUsers
  case userDetails
  case follower
  case following
  case blog
  case loadMoreUser
  case findingUsers

  var localized: String {
    NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
  }
}
