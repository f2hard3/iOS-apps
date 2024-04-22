

import Foundation
import UIKit
//import _Concurrency
//import CoreLocation

let path = Bundle.main.path(forResource: "Customers", ofType: "txt")!
        
let fileHandle = FileHandle(forReadingAtPath: path)

Task {
    for try await line in fileHandle!.bytes {
        print(line)
    }
}

Task {
    let url = URL(filePath: path)
    
    for try await line in url.lines {
        print(line)
    }
}

let url = URL(string: "https://www.google.com")!

Task {
    let (bytes, response) = try await URLSession.shared.bytes(from: url)
    
    for try await byte in bytes {
        print(byte)
    }
}

Task {
    let center = NotificationCenter.default
    
    let _ = await center.notifications(named: UIApplication.didEnterBackgroundNotification).first { notification in
        guard let key = notification.userInfo?["key"] as? String else { return false }
        
        return key == "SomeValue"
    }
}


