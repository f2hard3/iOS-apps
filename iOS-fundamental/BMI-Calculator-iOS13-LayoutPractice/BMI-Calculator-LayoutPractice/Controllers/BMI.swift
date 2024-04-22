import UIKit

struct BMI {
    let value: Float
    let advice: String
    let color: UIColor
    
    func getBMIValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", value)
        
        return bmiTo1DecimalPlace
    }
}
