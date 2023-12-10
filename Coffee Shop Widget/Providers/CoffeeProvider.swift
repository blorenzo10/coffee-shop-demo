//
//  CoffeeProvider.swift
//  Coffee Shop WidgetExtension
//
//  Created by Bruno Lorenzo on 5/12/23.
//

import WidgetKit

struct CoffeeProvider: TimelineProvider {
    typealias Entry = CoffeeOrder
    
    func placeholder(in context: Context) -> CoffeeOrder {
        return CoffeeOrder(date: .now, coffees: 1, lastCoffee: "Small Latte")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CoffeeOrder) -> Void) {
        completion(CoffeeOrder(date: .now, coffees: 1, lastCoffee: "Small Latte"))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CoffeeOrder>) -> Void) {
        OrdersManager.shared.addRandomOrder()
        if let lastCoffee = OrdersManager.shared.getLastCoffee() {
            let timeline = Timeline(
                entries: [CoffeeOrder(date: .now, coffees: OrdersManager.shared.ordersWithCoffee(), lastCoffee: lastCoffee)],
                policy: .atEnd
            )
            completion(timeline)
        }
    }
}
