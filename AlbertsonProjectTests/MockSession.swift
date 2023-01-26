//
//  MockSession.swift
//  AlbertsonProjectTests
//
//  Created by Kingsley Enoka on 1/26/23.
//

import Foundation

@testable import AlbertsonProject

class MockSession: Session {
  var dataResult: (Data, URLResponse)!
  
  func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
    return dataResult
  }
}
