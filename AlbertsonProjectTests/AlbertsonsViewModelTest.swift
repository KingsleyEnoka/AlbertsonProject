//
//  AlbertsonsViewModelTest.swift
//  AlbertsonProjectTests
//
//  Created by Kingsley Enoka on 1/26/23.
//

import XCTest
@testable import AlbertsonProject

class AlbertsonsViewModelTest: XCTestCase {

  var sut: AlbertsonsViewModel!
  var networkLayer: MockNetworkLayer!
  
  override func setUp() {
    networkLayer = MockNetworkLayer()
    sut = AlbertsonsViewModel(networkLayer: networkLayer)
  }

  func test_successful_getRandomCatFact() async {
    let jsonObj = AlbertsonsModel.TestingVariation.someFacts()
    networkLayer.getDataResult = jsonObj
    await sut.getRandomCatFact()
    XCTAssertEqual(sut.fact, jsonObj.data[0])
  }
  
  func test_failed_getRandomCatFact() async {
    let error = NetworkError.serverError
    networkLayer.error = error
    await sut.getRandomCatFact()
    XCTAssertEqual(sut.errorDescription, error.localizedDescription)
  }
  
  func test_changeSize() {
    sut.changeSize()
    XCTAssertEqual(sut.changedSize, 105)
  }
}
