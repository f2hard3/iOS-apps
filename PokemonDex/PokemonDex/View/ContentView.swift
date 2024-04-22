//
//  ContentView.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/05.
//

import SwiftUI
import CoreData

struct ContentView: View {   
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default
    ) private var pokeDex: FetchedResults<Pokemon>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        predicate: NSPredicate(format: "favorite = %d", true),
        animation: .default
    ) private var favorites: FetchedResults<Pokemon>
    
    @State var filterByFavorite = false
    
    @StateObject private var pokemonVM = PokemonViewModel(controller: FetchController())
    
    
    
    
    var body: some View {
        switch pokemonVM.status {
        case .success:
            NavigationView {
                List(filterByFavorite ? favorites : pokeDex) { pokemon in
                    NavigationLink {
                        PokemonDetail()
                            .environmentObject(pokemon)
                    } label: {
                        AsyncImage(url: pokemon.sprite) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        
                        Text(pokemon.name!.capitalized)
                        
                        if pokemon.favorite {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                    
                } // List
                .navigationTitle("Pokedex")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                filterByFavorite.toggle()
                            }
                        } label: {
                            Label("Filter By Favorites", systemImage: filterByFavorite ? "star.fill" : "star")
                        }
                        .tint(.yellow)
                        
                    }
                }
            } // NavigationView
            
        default:
            ProgressView()
        } // switch
        
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
