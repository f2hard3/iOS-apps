//
//  CurrentDateViewModel.swift
//  GettingStartedAsyncAwait
//
//  Created by Sunggon Park on 2024/04/12.
//

import Foundation

@MainActor
class CurrentDateViewModel: ObservableObject {
    @Published var currentDates: [CurrentDate] = []
    
    let service = WebService()
    
    func populateDates() async {
        do {
            guard let date = try await service.getDate() else { return }
            currentDates.append(date)
        } catch {
            print("error:", error)
        }
    }
}

