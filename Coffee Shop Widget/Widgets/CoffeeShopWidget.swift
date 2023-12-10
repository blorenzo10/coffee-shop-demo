//
//  CoffeeShopWidget.swift
//  Coffee Shop WidgetExtension
//
//  Created by Bruno Lorenzo on 5/12/23.
//

import SwiftUI
import WidgetKit

struct CoffeeShopWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.blorenzo.coffeeshop.last-order",
            provider: CoffeeProvider()) { order in
                LastOrderView(order)
            }
            .supportedFamilies([.systemSmall])
    }
}

#Preview(as: WidgetFamily.systemSmall) {
    CoffeeShopWidget()
} timeline: {
    CoffeeOrder(date: .now, coffees: 1, lastCoffee: "Small Latte")
    CoffeeOrder(date: .now, coffees: 2, lastCoffee: "Medium Cappuccino")
}
