//
//  Store.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/11.
//

import Foundation
import StoreKit

enum BookStatus: Codable {
    case active, inactive, locked
}

@MainActor
class Store: ObservableObject {
    @Published var books: [BookStatus] = [.active, .active, .inactive, .locked, .locked, .locked, .locked]
    
    @Published var products: [Product] = []
    @Published var purchasedIDs = Set<String>()
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    
    private var savePath: URL {
        if #available(iOS 16.0, *) {
            return FileManager.documentDirectory.appending(path: "SavedBookStatus")
        } else {
            return FileManager.documentDirectory.appendingPathComponent("SavedBookStatus")
        }
    }
    
    init() {
        watchForUpdates()
    }
    
    func loadProducts() async {
        do {
            products = try await Product.products(for: productIDs)
            products.sort { $0.displayName < $1.displayName }
        } catch {
            print("Couldn't fetch those products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified(let signedType, let verificationError):
                    print("Error on \(signedType): \(verificationError)")
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                }
            case .userCancelled:
                break
            case .pending:
                break
            @unknown default:
                break
            }
        } catch {
            print("Couldn't purchase that products: \(error)")
        }
    }
    
    private func checkPurchased() async {
        for product in products {
            guard let state = await product.currentEntitlement else { return }
            switch state {
            case .unverified(let signedType, let verificationError):
                print("Error on \(signedType): \(verificationError)")
            case .verified(let signedType):
                if signedType.revocationDate == nil {
                    purchasedIDs.insert(signedType.productID)
                }
                else {
                    purchasedIDs.remove(signedType.productID)
                }
            }
        }
    }
    
    private func watchForUpdates() {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                await checkPurchased()
            }
        }
    }
    
    func saveStatus() {
        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: savePath)
        } catch {
            print("Unable to save data: \(error)")
        }
    }
    
    func loadStatus() {
        do {
            let data = try Data(contentsOf: savePath)
            books = try JSONDecoder().decode([BookStatus].self, from: data)
        } catch {
            print("Unable to load book statuses: \(error)")
        }
    }
}
