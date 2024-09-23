//
//  RequestProtocol.swift
//  TakeHome
//
//  Created by Duy Phuong on 19/09/2024.
//

import Foundation

protocol RequestProtocol {
  var path: String { get }
  var requestType: RequestType { get }
  var headers: [String: String] { get }
  var params: [String: Any] { get }
  var urlParams: [String: String?] { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
  var host: String {
    APIConstants.host
  }
  
  var addAuthorizationToken: Bool {
    true
  }
  
  var params: [String: Any] {
    [:]
  }
  
  var urlParams: [String: String?] {
    [:]
  }
  
  var headers: [String: String] {
    [:]
  }
  
  func request() throws -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    
    if urlParams.isNotEmpty {
      components.queryItems = urlParams.map { key, value in
        URLQueryItem(name: key, value: value)
      }
    }
    
    guard let url = components.url else { throw  NetworkError.invalidURL }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue
    
    if headers.isNotEmpty {
      urlRequest.allHTTPHeaderFields = headers
    }
    
    urlRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    if params.isNotEmpty {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
    }
    
    return urlRequest
  }
}
