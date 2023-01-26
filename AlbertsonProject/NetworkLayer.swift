//
//  NetworkLayer.swift
//  AlbertsonProject
//
//  Created by Kingsley Enoka on 1/26/23.
//

import Foundation

protocol Session {
  func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: Session{}

protocol NetworkLayer {
  func getData<T: Decodable>(urlString: String) async throws -> T
}

class NetworkLayerImpl: NetworkLayer {
  static let shared = NetworkLayerImpl()
  let session: Session
  
  init(session: Session = URLSession.shared) {
    self.session = session
  }
  
  func getData<T: Decodable>(urlString: String) async throws -> T {
    guard let url = URL(string: urlString) else {
      throw NetworkError.urlError
    }
    
    let (data, response) = try await session.data(from: url, delegate: nil)
    
    if let response = response as? HTTPURLResponse {
      if (200...299).contains(response.statusCode) {
        let jsonObj = try JSONDecoder().decode(T.self, from: data)
        return jsonObj
      } else {
        throw NetworkError.serverError
      }
    } else {
      throw NetworkError.responseError
    }
    
  }
}
enum NetworkError: Error {
  case urlError
  case responseError
  case serverError
}
