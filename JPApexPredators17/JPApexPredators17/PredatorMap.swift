//
//  PredatorMap.swift
//  JPApexPredators17
//
//  Created by Sunggon Park on 2024/04/03.
//

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct PredatorMap: View {
    private let predators = Predators()
    
    @State var position: MapCameraPosition
    @State private var satellite = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.allApexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
                .annotationTitles(.hidden)
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard)
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(4)
                    .background(.ultraThinMaterial)
                    .clipShape(.buttonBorder)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

@available(iOS 17.0, *)
#Preview {
    PredatorMap(position:
                .camera(
                    MapCamera(
                        centerCoordinate: Predators().apexPredators[2].location,
                        distance: 1000,
                        heading: 250,
                        pitch: 80
                    )
                )
    )
    .preferredColorScheme(.dark)
}
