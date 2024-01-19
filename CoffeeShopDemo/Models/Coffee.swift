//
//  MenuItem.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import Foundation
import SwiftUI
import AppIntents
import Charts

enum Coffee: String, MenuItemInfo, Plottable {
    
    case latte = "Latte"
    case cappuccino = "Cappuccino"
    case cortado = "Cortado"
    case flatwhite = "FlatWhite"
    
    var name: String {
        switch self {
        case .latte:
            return String(localized: "Latte")
        case .cappuccino:
            return String(localized: "Cappuccino")
        case .cortado:
            return String(localized: "Cortado")
        case .flatwhite:
            return String(localized: "Flat White")
        }
    }
    
    var localizeDescription: AttributedString? {
        return nil
    }
    
    var thumbnail: Image {
        switch self {
        case .latte:
            return Image("latte")
        case .cappuccino:
            return Image("cappuccino")
        case .cortado:
            return Image("cortado")
        case .flatwhite:
            return Image("flatwhite")
        }
    }
    
    var icon: Image {
        return Image("coffee_icon")
    }
    
    var availableSizes: [MenuItemSize] {
        return MenuItemSize.allCases
    }
    
    var sizeDescriptions: [MenuItemSize : String]? {
        return [
            .small: "8 fl oz",
            .regular: "12 fl oz",
            .large: "14 fl oz"
        ]
    }
    
    var price: Price {
        var prices = Price()
        switch self {
        case .latte:
            prices[.small] = 3.5
            prices[.regular] = 4.5
            prices[.large] = 5
        case .cappuccino:
            prices[.small] = 4.0
            prices[.regular] = 4.5
            prices[.large] = 6
        case .cortado:
            prices[.small] = 4
            prices[.regular] = 5
            prices[.large] = 5.5
        case .flatwhite:
            prices[.small] = 4
            prices[.regular] = 5
            prices[.large] = 5.5
        }
        return prices
    }
}
