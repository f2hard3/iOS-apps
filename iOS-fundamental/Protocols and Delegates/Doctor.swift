import Foundation

class Doctor: AdvancedLiftSupport {
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func doPerformCPR() {
        print("performCPR by \(self))")
    }
}
