import Foundation

class EmergencyCallHandler {
    var delegate: AdvancedLiftSupport?
    
    func medicalEmergency() {
        delegate?.doPerformCPR()
    }
}
