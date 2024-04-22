//
//  Settings.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/09.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: Store
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                Text("Whick books would you like to see questions from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(0..<store.books.count, id: \.self) { i in
                            if store.books[i] == .active || (store.books[i] == .locked && store.purchasedIDs.contains("hp\(i + 1)")){
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 8)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green)
                                        .shadow(radius: 2)
                                        .padding(4)
                                } // ZStack
                                .task {
                                    store.books[i] = .active
                                    store.saveStatus()
                                }
                                .onTapGesture {
                                    store.books[i] = .inactive
                                    store.saveStatus()
                                }
                            } else if store.books[i] == .inactive {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 8)
                                        .overlay(Rectangle().opacity(0.4))
                                    
                                    Image(systemName: "circle")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green.opacity(0.4))
                                        .shadow(radius: 2)
                                        .padding(4)
                                    
                                } // ZStack
                                .onTapGesture {
                                    store.books[i] = .active
                                    store.saveStatus()
                                }
                            } else {
                                ZStack() {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 8)
                                        .overlay(Rectangle().opacity(0.8))
                                    
                                    Image(systemName: "lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color: .white.opacity(0.8), radius: 4)
                                } // ZStack
                                .onTapGesture {
                                    let product = store.products[i - 3]
                                    
                                    Task {
                                        await store.purchase(product)
                                    }
                                }
                            }
                        }
                    } // LazyVGrid
                    .padding()
                } // ScrollView
                
                Button("Done") {
                    dismiss()
                }
                .doneButton()
            }
        } // ZStack
        .foregroundStyle(.black)
    }
}

#Preview {
    Settings()
        .environmentObject(Store())
}
