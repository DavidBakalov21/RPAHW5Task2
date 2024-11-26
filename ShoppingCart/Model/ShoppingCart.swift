import Foundation

final class ShoppingCart {
    private(set) var items: [Item] = []
    private var appliedCoupons: [Coupon] = []
    
    // Adds an item to the cart
    func addItem(_ item: Item) {
        items.append(item)
    }
    // https://developer.apple.com/documentation/swift/array/removeall(where:)-5k61r
    // Removes an item from the cart
    func removeItem(_ item: Item) {
        items.removeAll { $0.name == item.name }
    }
    
    // Calculates the total price without discount
    func calculateTotalPrice() -> Double {
        var resultPrice: Double = 0
        for item in items {
            resultPrice += item.price * Double(item.quantity)
        }
        return resultPrice
    }
    
    // Calculates the final price after applying discount
    // https://www.avanderlee.com/swift/where-using-swift/
    @discardableResult
    func applyCoupon(_ coupon: Coupon) -> Bool {
        if coupon.usageLimit > coupon.usageCount && !appliedCoupons.contains(where: {coupon.code == $0.code}) {
            appliedCoupons.append(coupon)
            return true
        }
        return false
    }
    
    // Calculate final price with coupon discounts
    func calculateFinalPrice() -> Double {
        var totalPrice = calculateTotalPrice()
        for appliedCoupon in appliedCoupons {
            if let discount = appliedCoupon.apply(to: totalPrice), appliedCoupon.maxDiscount < totalPrice {
                totalPrice -= discount
            }
        }
        return totalPrice
    }

}
