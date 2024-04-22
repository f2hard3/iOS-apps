//
//  ApexPredator.swift
//  JPApexPredators17
//
//  Created by Sunggon Park on 2024/04/03.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //    enum CodingKeys: String, CodingKey {
    //        case id
    //        case name
    //        case type
    //        case latitude
    //        case longitude
    //        case movies
    //        case movieScenes = "movie_scenes"
    //        case link
    //    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
        
        //        enum CodingKeys: String, CodingKey {
        //            case id
        //            case movie
        //            case sceneDescription = "scene_description"
        //        }
    }
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: PredatorType {
        self
    }
    
    var background: Color {
        switch self {
        case .all:
                .black
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}


