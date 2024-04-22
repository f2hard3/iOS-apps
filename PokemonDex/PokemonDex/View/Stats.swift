//
//  Stats.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/05.
//

import SwiftUI
import Charts

struct Stats: View {
    let pokemon: Pokemon
    
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart(pokemon.stats) { stat in
                BarMark(
                    x: .value("Value", stat.value),
                    y: .value("State", stat.label)
                )
                .annotation(position: .trailing) {
                    Text("\(stat.value)")
                        .padding(.bottom, 5)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            } // Chart
            .frame(height: 200)
            .padding([.leading, .trailing, .bottom])
            .foregroundStyle(Color(pokemon.types![0].capitalized))
            .chartXScale(domain: 0...pokemon.highestStat.value + 8)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    Stats(pokemon: SamplePokemon.samplePokemon)
}
