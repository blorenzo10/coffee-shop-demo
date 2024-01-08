//
//  OrdersManager.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 21/9/23.
//

import Foundation

final class OrdersManager {
    
    static let shared = OrdersManager()
    private(set) var orders = [Order]()
    
    private init() {}
    
    func add(_ order: Order) throws {
        if order.price >= 10 {
            orders.append(order)
            LiveActivityManager.shared.simulate()
        } else {
            throw AppError(type: OrderError.minimumNotMet(currentPrice: order.price))
        }
    }
    
    func repeatLastOrder() {
        if let lastOrder = orders.last {
            orders.append(lastOrder)
        }
    }
    
    func getLastCoffee() -> String? {
        for order in orders.reversed() {
            if let coffeeItem = order.items.first(where: { $0.item.isType(Coffee.self) }) {
                return "\(coffeeItem.size.description) \(coffeeItem.item.name)"
            }
        }
        return nil
    }
    
    func ordersWithCoffee() -> Int {
        var result = 0
        for order in orders.reversed() {
            if order.items.first(where: { $0.item.isType(Coffee.self) }) != nil {
                result += 1
            }
        }
        return result
    }
    
    func addRandomOrder() {
        if orders.isEmpty {
            try? add(Order(items: [OrderItem(item: AnyMenuItem(Coffee.flatwhite), size: .small, quantity: 1)]))
        }
    }
}
