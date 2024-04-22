//
//  PredatorDetail.swift
//  JPApexPredators17
//
//  Created by Sunggon Park on 2024/04/03.
//

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    @State private var imageTapped = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .clear, location: 0.8),
                                    Gradient.Stop(color: .black, location: 1)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geo.size.width / 1.5,
                            height: geo.size.height / 3
                        )
                        .shadow(color: .black, radius: 8)
                        .scaleEffect(x: -1)
                        .offset(y: 20)
                        .onTapGesture {
                            imageTapped.toggle()
                        }
                } // ZStack
                
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    NavigationLink {
                        PredatorMap(position:
                                .camera(
                                    MapCamera(
                                        centerCoordinate: predator.location,
                                        distance: 1000,
                                        heading: 250,
                                        pitch: 80
                                    )
                                )
                        )
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 128)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.medium)
                                .padding(.trailing, 4)
                            
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .trailing], 8)
                                .padding([.bottom], 4)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 16))
                        }
                        .clipShape(.buttonBorder)
                    }
                    
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("• \(movie)")
                            .font(.subheadline)
                    }
                    
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 16)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 4)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 16)
                    }
                    
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                } // VStack
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
            } // ScrollView
            .ignoresSafeArea()
        } // GeometryReader
        .toolbarBackground(.automatic)
        .sheet(isPresented: $imageTapped, content: {
            Image(predator.image)
                .resizable()
                .scaledToFit()
        })
        
    } // body
}

@available(iOS 17.0, *)
#Preview {
    NavigationStack {
        PredatorDetail(
            predator: Predators().apexPredators[2],
            position: .camera(
                MapCamera(
                    centerCoordinate: Predators().apexPredators[2].location,
                    distance: 30000
                )
            )
        )
        .preferredColorScheme(.dark)
    }
}
