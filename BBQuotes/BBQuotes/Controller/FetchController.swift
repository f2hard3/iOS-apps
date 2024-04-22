//
//  FetchController.swift
//  BBQuotes
//
//  Created by Sunggon Park on 2024/04/04.
//

import Foundation

struct FetchController {
    private enum NetworkError: Error {
        case badURL, badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURL = baseURL.appendingPathComponent("quotes/random")
        var quoteComponents = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true)
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
        quoteComponents?.queryItems = [quoteQueryItem]
        
        guard let fetchURL = quoteComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        var baseComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        baseComponents.path = baseComponents.path + "/characters"
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        baseComponents.queryItems = [characterQueryItem]
        
        guard let fetchURL = baseComponents.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
}
