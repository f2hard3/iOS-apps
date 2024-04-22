//
//  ContentView.swift
//  RandomQuoteAndImages
//
//  Created by Mohammad Azam on 7/14/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var randomImageListVM = RandomImageViewModelList()
    
    var body: some View {
        NavigationView {
            List(randomImageListVM.images) { randomImage in
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .scaledToFit()
                    }
                    Text(randomImage.quote)
                }
            }
            .task {
                await randomImageListVM.getRandomImages(ids: Array(100...200))
            }
            .navigationTitle("Random Image/Quote")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task.init {
                            await randomImageListVM.getRandomImages(ids: Array(100...200))
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
