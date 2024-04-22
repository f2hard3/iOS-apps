//
//  PokemonDexApp.swift
//  PokemonDex
//
//  Created by Sunggon Park on 2024/04/05.
//

import SwiftUI

@main
struct PokemonDexApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
