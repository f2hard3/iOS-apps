import Foundation

class BitcoinPriceMonitor {
    var price: Double = 0.0
    var timer: Timer?
    var priceHandler: (Double) -> Void = { _ in }
    
    func startUpdating() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getPrice), userInfo: nil, repeats: true)
    }
    
    @objc func getPrice() {
        priceHandler(Double.random(in: 50000...100000))
    }
    
    func stopUpdating() {
        timer?.invalidate()
    }
}

//let bitcoinPriceMonitor = BitcoinPriceMonitor()
//bitcoinPriceMonitor.priceHandler = {
//    print($0)
//}
//
//bitcoinPriceMonitor.startUpdating()

let bitcoinPriceStream = AsyncStream(Double.self) { continuation in
    let bitcoinPriceMonitor = BitcoinPriceMonitor()
    
    bitcoinPriceMonitor.priceHandler = {
        continuation.yield($0)
    }
    
    bitcoinPriceMonitor.startUpdating()
}

Task {
    for await bitcoinPrice in bitcoinPriceStream {
        print(bitcoinPrice)
    }
}
