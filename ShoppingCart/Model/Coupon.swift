import Foundation

final class Coupon {
    let code: String
    let discountPercentage: Double
    let maxDiscount: Double
    var usageLimit: Int
    private(set) var usageCount: Int = 0
    
    init(code: String, discountPercentage: Double, maxDiscount: Double, usageLimit: Int) {
        self.code = code
        self.discountPercentage = discountPercentage
        self.maxDiscount = maxDiscount
        self.usageLimit = usageLimit
    }
    
    // Method to apply the coupon if usage limit not reached
    func apply(to total: Double) -> Double? {
        if usageCount < usageLimit {
            usageCount += 1
            let appliedDiscount = min((discountPercentage/100) * total, maxDiscount)
            return appliedDiscount
        } else {
            return nil
        }
    }
}
