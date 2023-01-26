//
//  AlbertsonViewModel.swift
//  AlbertsonProject
//
//  Created by Kingsley Enoka on 1/26/23.
//

import Foundation

class AlbertsonsViewModel: ObservableObject {
  let networkLayer: NetworkLayer
  @Published var fact = ""
  @Published var changedSize = 100
  var errorDescription: String?
  
  init(networkLayer: NetworkLayer = NetworkLayerImpl.shared) {
    self.networkLayer = networkLayer
  }
  
  @MainActor
  func getRandomCatFact() async {
    do {
      let jsonObj: AlbertsonsModel = try await networkLayer.getData(urlString: catFactURL)
      fact = jsonObj.data[0]
    } catch {
      self.errorDescription = error.localizedDescription
    }
  }
  
  func changeSize() {
    changedSize += 5
  }
}
