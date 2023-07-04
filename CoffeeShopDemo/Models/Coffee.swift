//
//  MenuItem.swift
//  automatic-grammar-agreement-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import Foundation
import SwiftUI

enum Coffee: MenuItemInfo {
    
    case latte
    case cappuccino
    case mocha
    case flatwhite
    
    var name: String {
        switch self {
        case .latte:
            return "Latte"
        case .cappuccino:
            return "Cappuccino"
        case .mocha:
            return "Mocha"
        case .flatwhite:
            return "Flat White"
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
        case .mocha:
            return Image("mocha")
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
        case .mocha:
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
