//
//  RandomImageViewModel.swift
//  RandomQuoteAndImages
//
//  Created by Sunggon Park on 2024/04/13.
//

import Foundation
import SwiftUI

@MainActor
class RandomImageViewModelList: ObservableObject {
    @Published var images: [RandomImageViewModel] = []
    
    func getRandomImages(ids: [Int]) async {
        let webService = Webservice()
        images = []
        
        do {
//            let randomImages = try await Webservice().getRandomImages(ids: ids)
//            images = randomImages.map(RandomImageViewModel.init)
            
            try await withThrowingTaskGroup(of: RandomImage.self) { group in
                for id in ids {
                    group.addTask {
                        try await webService.getRandomImage(id: id)
                    }
                }
                
                for try await randomImage in group {
                    images.append(RandomImageViewModel(randomImage: randomImage))
                }
            }
        } catch {
            print(error)
        }
    }
}

struct RandomImageViewModel: Identifiable {
    let id = UUID()
    
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
