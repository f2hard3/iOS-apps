//
//  ContentView.swift
//  JPApexPredators17
//
//  Created by Sunggon Park on 2024/04/03.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection: PredatorType = .all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        if #available(iOS 17.0, *) {
            NavigationStack {
                List(filteredDinos) { predator in
                    NavigationLink {
                        PredatorDetail(
                            predator: predator,
                            position: .camera(
                                MapCamera(
                                    centerCoordinate: predator.location,
                                    distance: 30000
                                )
                            )
                        )
                    } label: {
                        HStack {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .shadow(color: .white, radius: 1)
                            
                            VStack(alignment: .leading) {
                                Text(predator.name)
                                    .fontWeight(.bold)
                                
                                Text(predator.type.rawValue.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(predator.type.background)
                                    .clipShape(.capsule)
                                
                            }
                        } // Hstack
                    } // NavigationLink
                } // List
                .navigationTitle("Apex Predators")
                .searchable(text: $searchText)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .animation(.default, value: searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                alphabetical.toggle()
                            }
                        } label: {
                            Image(systemName: alphabetical ? "film" : "textformat")
                                .symbolEffect(.bounce, value: alphabetical)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Filter", selection: $currentSelection.animation()) {
                                ForEach(PredatorType.allCases) { type in
                                    Label(type.rawValue.capitalized, systemImage: type.icon)
                                }
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                        
                    }
                }
            } // NavigationStack
            .preferredColorScheme(.dark)
        } else {
            NavigationView {
                List(filteredDinos) { predator in
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                        HStack {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .shadow(color: .white, radius: 1)
                            
                            VStack(alignment: .leading) {
                                Text(predator.name)
                                    .fontWeight(.bold)
                                
                                Text(predator.type.rawValue.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(predator.type.background)
                                    .clipShape(.capsule)
                                
                            }
                        }
                    }
                }
                .navigationTitle("Apex Predators")
                .searchable(text: $searchText)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .animation(.default, value: searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                alphabetical.toggle()
                            }
                        } label: {
                            Image(systemName: alphabetical ? "film" : "textformat")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Filter", selection: $currentSelection.animation()) {
                                ForEach(PredatorType.allCases) { type in
                                    Label(type.rawValue.capitalized, systemImage: type.icon)
                                }
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
