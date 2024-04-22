//
//  SamplePokemon.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/05.
//

import Foundation
import CoreData

struct SamplePokemon {
    static let samplePokemon: Pokemon = {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        let results = try! context.fetch(fetchRequest)
        
        return results.first!
    }()
}
