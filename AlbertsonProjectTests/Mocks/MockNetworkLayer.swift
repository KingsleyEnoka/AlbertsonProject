//
//  MockNetworkLayer.swift
//  AlbertsonProjectTests
//
//  Created by Kingsley Enoka on 1/26/23.
//

import Foundation
@testable import AlbertsonProject

class MockNetworkLayer: NetworkLayer {
  
  var getDataResult: AlbertsonsModel!
  var error: NetworkError?
  
  func getData<T>(urlString: String) async throws -> T where T : Decodable {
    if let error = error {
      throw error
    } else {
      return getDataResult as! T
    }
  }
}
