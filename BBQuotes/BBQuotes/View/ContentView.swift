//
//  ContentView.swift
//  BBQuotes
//
//  Created by Sunggon Park on 2024/04/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show: K.bbName)
                .tabItem {
                    Label(K.bbName, systemImage: "tortoise")
                }
            
            QuoteView(show: K.bcsName)
                .tabItem {
                    Label(K.bcsName, systemImage: "briefcase")
                }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
