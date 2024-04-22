//
//  ContentView.swift
//  Hacker-News
//
//  Created by Sunggon Park on 2024/02/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack{
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Hacker News")
        }
        .onAppear {
            Task { @MainActor in
                await networkManager.fetchData()
            }            
        }
    }
}

#Preview {
    ContentView()
}
