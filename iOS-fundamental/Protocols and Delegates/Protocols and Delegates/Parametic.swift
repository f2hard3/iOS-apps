import Foundation

struct Parametic: AdvancedLiftSupport {
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func doPerformCPR() {
        print("performCPR by \(self))")
    }
}
