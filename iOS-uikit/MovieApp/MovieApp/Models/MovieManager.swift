//
//  MovieManager.swift
//  MovieApp
//
//  Created by Sunggon Park on 2024/03/21.
//

import Foundation

struct MovieManager {
    func fetchMovieData(searchTerm: String = "marvel") async throws -> MovieModel {
        let baseUrl = "https://itunes.apple.com/search"
        let urlRequest = try makeRequest(url: baseUrl, term: searchTerm)
        let data = try await requestData(with: urlRequest)
        
        return try decode(data: data)
    }
    
    typealias FetchCompletion = (Data) -> Void
    func fetchImage(url: String, completion: @escaping FetchCompletion) {
        Task {
            do {
                let request = try makeRequest(url: url)
                let data = try await requestData(with: request)
                completion(data)
            } catch {
                print(error)
            }
        }
    }
    
    func formatDate(from: String) -> String? {
        guard let iso8601Date = ISO8601DateFormatter().date(from: from) else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        return formatter.string(from: iso8601Date)
    }
    
    private func makeRequest(url: String, term: String? = nil) throws -> URLRequest {
        var urlComponent = URLComponents(string: url)
        
        if term != nil {
            urlComponent?.queryItems = [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "media", value: "movie")
            ]
        }
        
        guard let url = urlComponent?.url else {
            fatalError("Failed to get url from url component")
        }
        
        return URLRequest(url: url)
    }
    
    private func requestData(with urlRequest: URLRequest) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
                
        return data
    }
    
    private func decode(data: Data) throws -> MovieModel {
        let movieModel = try JSONDecoder().decode(MovieModel.self, from: data)
        
        return movieModel
    }
}
