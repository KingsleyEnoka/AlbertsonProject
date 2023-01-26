//
//  ContentView.swift
//  AlbertsonProject
//
//  Created by Kingsley Enoka on 1/26/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var vm = AlbertsonsViewModel()
  
    var body: some View {
      ScrollView {
        VStack {
          AsyncImage(
            url: URL(string: "\(catImageBaseURL)\(vm.changedSize)/\(vm.changedSize)"),
            content: { image in
            image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 300, maxHeight: 300)
            },
            placeholder: {
              ProgressView()
            }
          )
          Text(vm.fact)
            .multilineTextAlignment(.leading)
            .padding()
          Spacer()
        }
        
        .task {
          await vm.getRandomCatFact()
        }
      }
      .onTapGesture {
        vm.changeSize()
        Task {
          await vm.getRandomCatFact()
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
