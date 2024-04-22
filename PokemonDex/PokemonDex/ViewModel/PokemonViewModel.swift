//
//  PokemonViewModel.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/05.
//

import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    init(controller: FetchController) {
        self.controller = controller
        
        Task {
            await getPokemon()
        }
    }
    
    @Published private(set) var status: Status = .notStarted
    
    private let controller: FetchController
    
    private func getPokemon() async {
        status = .fetching
        
        do {
            guard var pokeDex = try await controller.fetchAllPokemonIfExists() else {
                print("Pokemon have already been got.")
                status = .success
                
                return
            }
            
            pokeDex.sort { $0.id < $1.id }
            
            let context = PersistenceController.shared.container.viewContext
            for pokemon in pokeDex {
                let newPokemon = Pokemon(context: context)
                newPokemon.id = Int16(pokemon.id)
                newPokemon.name = pokemon.name
                newPokemon.types = pokemon.types
                newPokemon.organizeTypes()
                newPokemon.hp = Int16(pokemon.hp)
                newPokemon.attack = Int16(pokemon.attack)
                newPokemon.defense = Int16(pokemon.defense)
                newPokemon.specialAttack = Int16(pokemon.specialAttack)
                newPokemon.specialDefense = Int16(pokemon.specialDefense)
                newPokemon.speed = Int16(pokemon.speed)
                newPokemon.sprite = pokemon.sprite
                newPokemon.shiny = pokemon.shiny
                newPokemon.favorite = false
                
                try context.save()
            }
            status = .success
        } catch {
            status = .failed(error: error)
        }
    }
}
