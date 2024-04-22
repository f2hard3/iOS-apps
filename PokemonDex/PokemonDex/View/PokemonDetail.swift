//
//  PokemonDetail.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/05.
//

import SwiftUI
import CoreData

struct PokemonDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var pokemon: Pokemon
    
    @State private var showShiny = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(pokemon.background)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 8)
                
                AsyncImage(url: showShiny ? pokemon.shiny : pokemon.sprite) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 48)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 8)
                } placeholder: {
                    ProgressView()
                }
            } // ZStack
            
            HStack {
                ForEach(pokemon.types!, id: \.self) { type in
                    Text(type.capitalized)
                        .font(.title2)
                        .shadow(color: .white, radius: 2)
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing])
                        .background(Color(type.capitalized))
                        .clipShape(.capsule)
                    
                }
                
                Spacer()
                
                Button {
                    pokemon.favorite.toggle()
                    
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                } label: {
                    if pokemon.favorite {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
                .font(.largeTitle)
                .foregroundStyle(.yellow)
            } // HStack
            .padding()
            
            Text("Stats")
                .font(.title)
                .padding(.bottom, -6)
            
            Stats(pokemon: pokemon)
        } // ScrollView
        .navigationTitle(pokemon.name!.capitalized)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showShiny.toggle()
                } label: {
                    if showShiny {
                        Image(systemName: "wand.and.stars")
                            .foregroundStyle(.yellow)
                    } else {
                        Image(systemName: "wand.and.stars.inverse")
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonDetail()
        .environmentObject(SamplePokemon.samplePokemon)
}
