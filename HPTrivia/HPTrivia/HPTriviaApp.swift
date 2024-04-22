//
//  HPTriviaApp.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/08.
//

import SwiftUI

@main
struct HPTriviaApp: App {
    @StateObject private var store = Store()
    @StateObject private var game = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(game)
                .task {
                    await store.loadProducts()
                    store.loadStatus()
                    game.loadScores()
                }
        }
    }
}
