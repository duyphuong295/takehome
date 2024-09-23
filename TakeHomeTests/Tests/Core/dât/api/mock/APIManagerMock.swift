//
//  APIManagerMock.swift
//  TakeHomeTests
//
//  Created by Duy Phuong on 21/09/2024.
//

import XCTest
@testable import TakeHome

struct APIManagerMock: APIManagerProtocol {
  func initRequest(with data: RequestProtocol) async throws -> Data {
    return try Data(contentsOf: URL(fileURLWithPath: data.path), options: .mappedIfSafe)
  }
}
