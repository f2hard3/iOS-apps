//
//  WebService.swift
//  GettingStartedAsyncAwait
//
//  Created by Sunggon Park on 2024/04/12.
//

import Foundation


struct CurrentDate: Decodable, Identifiable {
    let id = UUID()
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
    }
}

struct WebService {
    func getDate() async throws -> CurrentDate? {
        guard let url = URL(string: "https://ember-sparkly-rule.glitch.me/current-date") else {
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return nil
        }
        
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
}
