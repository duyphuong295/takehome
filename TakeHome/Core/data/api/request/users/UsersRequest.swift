//
//  UsersRequest.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import Foundation

enum UsersRequest: RequestProtocol {
  case getUsersWith(since: Int, perPage: Int)
  case getUserBy(name: String)
  
  var path: String {
    switch self {
    case .getUsersWith:
      return "/users"
    case let .getUserBy(name):
      return "/users/\(name)"
    }
  }
  
  var urlParams: [String: String?] {
    switch self {
    case let .getUsersWith(since, perPage):
      var params = ["since": String(since)]
      params["per_page"] = String(perPage)
      return params
    case .getUserBy:
      return [:]
    }
  }
  
  var requestType: RequestType {
    .GET
  }
}
