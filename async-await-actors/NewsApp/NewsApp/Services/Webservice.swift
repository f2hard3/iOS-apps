//
//  Webservice.swift
//  NewsApp
//
//  Created by Mohammad Azam on 6/30/21.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidData
    case decodingError
}

class Webservice {
    func fetchSources(url: URL?) async throws -> [NewsSource] {
        guard let url else {
            return []
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(NewsSourceResponse.self, from: data).sources
    }
           
    func fetchNews(url: URL?) async throws -> [NewsArticle] {
        return try await withCheckedThrowingContinuation { continuation in
            fetchNews(url: url) { result in
                switch result {
                case .success(let newsArticle):
                    continuation.resume(returning: newsArticle)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func fetchNews(url: URL?, completion: @escaping (Result<[NewsArticle], NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(.badUrl))
            return
        }
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let newsArticleResponse = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
            completion(.success(newsArticleResponse?.articles ?? []))
            
        }.resume()
        
    }
    
}
