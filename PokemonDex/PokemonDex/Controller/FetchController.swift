//
//  FetchController.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/05.
//

import Foundation
import CoreData

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse, badData
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAllPokemonIfExists() async throws -> [TempPokemon]? {
        if havePokemon() {
            return nil
        }
        
        return try await fetchAllPokemon()
    }
    
    func fetchAllPokemon() async throws -> [TempPokemon] {
        var allPokemon: [TempPokemon] = []
        
        var fetchComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        fetchComponents?.queryItems = [URLQueryItem(name: "limit", value: "386")]
        guard let fetchURL = fetchComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let pokeDictionanry = try JSONSerialization.jsonObject(with: data) as? [String: Any], let pokeDex = pokeDictionanry["results"] as? [[String: String]] else {
            throw NetworkError.badData
        }
        
        for pokemon in pokeDex {
            guard let urlString = pokemon["url"], let url = URL(string: urlString) else {
                throw NetworkError.badURL
            }
            
            allPokemon.append(try await fetchPokemon(from: url))
        }
        
        return allPokemon
    }
    
    private func fetchPokemon(from url: URL) async throws -> TempPokemon {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let result = try JSONDecoder().decode(TempPokemon.self, from: data)
        print("\(result.id): \(result.name)")
        
        return result
    }
    
    private func havePokemon() -> Bool {
        let context = PersistenceController.shared.container.newBackgroundContext()
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id IN %@", [1, 386])
        
        do {
            let checkPokemon = try context.fetch(fetchRequest)
            
            if checkPokemon.count == 2 {
                return true
            }
        } catch {
            print("Fetch failed: \(error)")
            return false
        }
        
        return false
    }
}
