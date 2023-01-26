//
//  AlbertsonsModel.swift
//  AlbertsonProject
//
//  Created by Kingsley Enoka on 1/26/23.
//

import Foundation

struct AlbertsonsModel: Codable, Equatable {
  let data: [String]
}

extension AlbertsonsModel {
  struct TestingVariation {
    static func someFacts() -> AlbertsonsModel {
      return AlbertsonsModel(data: ["Some cats like to sleep on your face when you sleep."])
    }
  }
}
