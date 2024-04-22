import UIKit

enum NetworkError: Error {
    case badUrl, decodingError, invalidId
}

struct CreditScore: Decodable {
    let score: Int
}

struct Constants {
    struct Urls {
        static func equifax(userId: Int) -> URL? {
            return URL(string: "https://ember-sparkly-rule.glitch.me/equifax/credit-score/\(userId)")
        }
        
        static func experian(userId: Int) -> URL? {
            return URL(string: "https://ember-sparkly-rule.glitch.me/experian/credit-score/\(userId)")
        }
    }
}

func calculateAPR(creditScores: [CreditScore]) -> Double {
    let sum = creditScores.reduce(0) { next, credit in
        return next + credit.score
    }
    
    return Double((sum / creditScores.count) / 100)
}

func getAPR(userId: Int) async throws -> Double {
    if userId % 2 == 0 {
        throw NetworkError.invalidId
    }
    
    guard let equifaxUrl = Constants.Urls.equifax(userId: userId),
          let experianUrl = Constants.Urls.experian(userId: userId) else {
        throw NetworkError.badUrl
    }
    
    async let (equifaxData, _) = URLSession.shared.data(from: equifaxUrl)
    async let (experianData, _) = URLSession.shared.data(from: experianUrl)
        
    let equifaxCreditScore = try? JSONDecoder().decode(CreditScore.self, from: await equifaxData)
    let experianCreditScore = try? JSONDecoder().decode(CreditScore.self, from: await experianData)
    
    guard let equifaxCreditScore, let experianCreditScore else {
        throw NetworkError.decodingError
    }
    
    return calculateAPR(creditScores: [equifaxCreditScore, experianCreditScore])
}


let ids = [1, 2, 3, 4, 5, 6]
Task {
    while !Task.isCancelled {
        for id in ids {
            try Task.checkCancellation()
            let apr = try await getAPR(userId: id)
            print(apr)
        }
    }
}

func getAPRForAllUsers(ids: [Int]) async throws -> [Int: Double] {
    var userAPR: [Int: Double] = [:]
    
    try await withThrowingTaskGroup(of: (Int, Double).self) { group in
        for id in ids {
            group.addTask {
                let apr = try await getAPR(userId: id)
                
                return (id, apr)
            }
        }
        
        for try await (id, apr) in group {
            userAPR[id] = apr
        }
    }
    
    
    
    return userAPR
}

let task = Task {
    let userAprs = try await getAPRForAllUsers(ids: ids)
    
    print(userAprs)
}
