//
//  Predators.swift
//  JPApexPredators17
//
//  Created by Sunggon Park on 2024/04/03.
//

import Foundation

class Predators {
    init() {
        decodeApexPredatorData()
    }
    
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    func decodeApexPredatorData() {
        guard let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy  = .convertFromSnakeCase
            allApexPredators = try decoder.decode([ApexPredator].self, from: data)
            apexPredators = allApexPredators
        } catch {
            print("Error decoding JSON data: \(error)" )
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        return searchTerm.isEmpty
        ? apexPredators
        : apexPredators.filter { predator in
            predator.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort {
            alphabetical
            ? $0.name < $1.name
            : $0.id < $1.id
        }
    }
    
    func filter(by type: PredatorType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter {
                $0.type == type
            }
        }        
    }
}
