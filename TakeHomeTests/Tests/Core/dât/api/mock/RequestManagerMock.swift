//
//  RequestManagerMock.swift
//  TakeHomeTests
//
//  Created by Duy Phuong on 21/09/2024.
//

import XCTest
@testable import TakeHome

class RequestManagerMock: RequestManagerProtocol {
  let apiManager: APIManagerProtocol
  
  init(apiManager: APIManagerProtocol) {
    self.apiManager = apiManager
  }
  
  func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T {
    let data = try await apiManager.initRequest(with: data)
    let decoded: T = try parser.parse(data: data)
    return decoded
  }
}
