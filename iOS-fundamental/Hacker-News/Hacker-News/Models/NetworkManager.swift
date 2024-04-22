//
//  NetworkManager.swift
//  Hacker-News
//
//  Created by Sunggon Park on 2024/02/29.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var posts = [Post]()
    
    func fetchData() async {
        guard let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") else {
            print("Error while creating url instance")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        do {
            let (data, _) =  try await session.data(from: url)
            let decoder = JSONDecoder()
            let results = try decoder.decode(Results.self, from: data)
            DispatchQueue.main.async {
                self.posts = results.hits
            }
        } catch {
            print(error)
        }
    }
}
