//
//  NetworkLayerTests.swift
//  AlbertsonProjectTests
//
//  Created by Kingsley Enoka on 1/26/23.
//

import XCTest
@testable import AlbertsonProject

class NetworkLayerTests: XCTestCase {

  var sut: NetworkLayerImpl!
  var session: MockSession!
  
  override func setUp() {
    session = MockSession()
    sut = NetworkLayerImpl(session: session)
  }
  
  func test_successful_getData() async {
    guard let url = URL(string: catFactURL),
    let urlResponse: URLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1.1", headerFields: nil) else {
      XCTFail()
      return
    }
    let jsonObj = AlbertsonsModel.TestingVariation.someFacts()
    do {
      let data = try JSONEncoder().encode(jsonObj)
      session.dataResult = (data, urlResponse)
      let obj: AlbertsonsModel = try await sut.getData(urlString: catFactURL)
      XCTAssertEqual(obj, jsonObj)
    } catch {
      XCTFail()
    }
  }
  
  func test_failed_getData() async {
    guard let url = URL(string: catFactURL),
    let urlResponse: URLResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "1.1", headerFields: nil) else {
      XCTFail()
      return
    }
    let jsonObj = AlbertsonsModel.TestingVariation.someFacts()
    do {
      let data = try JSONEncoder().encode(jsonObj)
      session.dataResult = (data, urlResponse)
      let _: AlbertsonsModel = try await sut.getData(urlString: catFactURL)
      XCTFail()
    } catch {
      XCTAssertEqual(error.localizedDescription, NetworkError.serverError.localizedDescription)
    }
  }
}

