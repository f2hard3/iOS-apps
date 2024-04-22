import Foundation

class CaculatorBrain {
    var result: Float = 0.0
    
    func calcuate(billText: String, tipPct: String, split: Int) {
        let totalAmount = Float(billText) ?? 0.0
        let tipFloatTyped = Float(tipPct.dropLast()) ?? 10.0
        let tipDecimalized = tipFloatTyped / 100.0
        
        result = (totalAmount * (1 + tipDecimalized)) / Float(split)
    }
}
