//
//  ContentView.swift
//  GettingStartedAsyncAwait
//
//  Created by Mohammad Azam on 7/9/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CurrentDateViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.currentDates, id: \.id) { date in
                Text("\(date.date)")
            }
            .listStyle(.plain)
            .navigationTitle("Dates")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.populateDates()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
        }
        .task {
            await viewModel.populateDates()
        }
    }
}

#Preview {
    ContentView()
}
