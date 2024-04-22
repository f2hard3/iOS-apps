import Foundation

var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int {
    get {
        let area: Float = width * height
        let areaCoverdPerBucket: Float = 1.5
        let numberOfBuckets: Float = area / areaCoverdPerBucket
        let roundedBuckets: Float = ceil(numberOfBuckets)
        
        return Int(roundedBuckets)
    }
    set {
        let areaCoverdPerBucket: Float = 1.5
        let totalArea = Float(newValue) * areaCoverdPerBucket
        
        print("Total area that can be covered \(totalArea)")
    }
}

bucketsOfPaint = 8
print(bucketsOfPaint)
