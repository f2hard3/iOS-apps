//
//  PokemonDexWidget.swift
//  PokemonDexWidget
//
//  Created by Sunggon Park on 2024/04/08.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    var randomPokomon: Pokemon {
        let context = PersistenceController.shared.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        var results: [Pokemon] = []
        
        do {
            results = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't fetch: \(error)")
        }
        
        if let randomPokemon = results.randomElement() {
            return randomPokemon
        }
        
        return SamplePokemon.samplePokemon
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), pokemon: SamplePokemon.samplePokemon)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), pokemon: randomPokomon)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, pokemon: randomPokomon)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let pokemon: Pokemon
}

struct PokemonDexWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetSize
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetSize {
        case .systemSmall:
            WidgetPokemon(pokemon: entry.pokemon, widgetSize: .small)
        case .systemMedium:
            WidgetPokemon(pokemon: entry.pokemon, widgetSize: .medium)
        case .systemLarge:
            WidgetPokemon(pokemon: entry.pokemon, widgetSize: .large)
        default:
            WidgetPokemon(pokemon: entry.pokemon, widgetSize: .small)
        }
    }
}

struct PokemonDexWidget: Widget {
    let kind: String = "PokemonDexWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                PokemonDexWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                PokemonDexWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    PokemonDexWidget()
} timeline: {
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
}

#Preview(as: .systemMedium) {
    PokemonDexWidget()
} timeline: {
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
}

#Preview(as: .systemLarge) {
    PokemonDexWidget()
} timeline: {
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
}
