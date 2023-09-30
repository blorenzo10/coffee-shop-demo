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
    
    func add(_ order: Order) {
        orders.append(order)
    }
}
