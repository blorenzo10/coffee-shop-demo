//
//  Cart.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 26/6/23.
//

import Foundation

struct OrderItem: Hashable {
    
    let id = UUID()
    let item: AnyMenuItem
    let size: MenuItemSize
    let quantity: Int
    
    var price: Float {
        return item.price[size]! * Float(quantity)
    }
    
    static func == (lhs: OrderItem, rhs: OrderItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class Order {
    
    var id = UUID()
    var items: [OrderItem]
    
    init(items: [OrderItem]) {
        self.items = items
    }
    
    init() {
        items = []
    }
    
    func add(item: OrderItem) {
        items.append(item)
    }
    
    func clear() {
        items.removeAll()
    }
    
    var price: Float {
        return items.reduce(0) { partialResult, item in
            partialResult + item.price
        }
    }
    
    var taxes: Float {
        return price * 0.18
    }
    
    var total: Float {
        return price + taxes
    }
}

extension Order: Hashable {
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
