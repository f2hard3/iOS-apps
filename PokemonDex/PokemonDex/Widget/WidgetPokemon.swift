//
//  WidgetPokemon.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/08.
//

import SwiftUI

enum WidgetSize {
    case small, medium, large
}

struct WidgetPokemon: View {
    let pokemon: Pokemon
    
    let widgetSize: WidgetSize
    
    var body: some View {
        ZStack {
            Color(pokemon.types![0].capitalized)
            
            switch widgetSize {
            case .small:
                FetchedImage(url: pokemon.sprite)
                
            case .medium:
                HStack {
                    FetchedImage(url: pokemon.sprite)
                    
                    VStack {
                        Text(pokemon.name!.capitalized)
                            .font(.title)
                        
                        Text(pokemon.types!.joined(separator: ", ").capitalized)
                    } // VStack
                    .padding(.trailing, 28)
                } // HStack
            case .large:
                FetchedImage(url: pokemon.sprite)
                
                VStack {
                    HStack {
                        Text(pokemon.name!.capitalized)
                            .font(.largeTitle)
                        
                        Spacer()
                    } // HStack
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text(pokemon.types!.joined(separator: ", ").capitalized)
                            .font(.title2)
                    } // HStack
                } // VStack
                .padding()
            }
        } // ZStack
    }
}

#Preview {
    WidgetPokemon(
        pokemon: SamplePokemon.samplePokemon,
        widgetSize: .large
    )
}
