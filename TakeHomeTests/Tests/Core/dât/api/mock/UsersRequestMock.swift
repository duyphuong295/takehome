//
//  UsersRequestMock.swift
//  TakeHomeTests
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation
@testable import TakeHome

enum UsersRequestMock: RequestProtocol {
case getUsers
case getUserByName
  
  var requestType: RequestType {
    return .GET
  }
  
  var path: String {
    switch self {
    case .getUsers:
      guard let path = Bundle.main.path(forResource: "UsersMock", ofType: "json") else { return "" }
      return path
    case .getUserByName:
      guard let path = Bundle.main.path(forResource: "SingleUserMock", ofType: "json") else { return "" }
      return path
    }
  }
}
