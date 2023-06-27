//
//  MenuItem.swift
//  automatic-grammar-agreement-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import Foundation
import SwiftUI

enum CoffeeSize: CaseIterable {
    case small
    case regular
    case large
    
    var description: String {
        switch self {
        case .small:
            return "Small"
        case .regular:
            return "Regular"
        case .large:
            return "Large"
        }
    }
    
    var ounces: String {
        switch self {
        case .small:
            return "8 fl oz"
        case .regular:
            return "12 fl oz"
        case .large:
            return "14 fl oz"
        }
    }
}

enum Drink: CaseIterable {
    
    typealias Price = [CoffeeSize: Float]
    
    case latte
    case cappuccino
    case mocha
    case flatwhite
    
    var image: Image {
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
    
    var price: Price {
        var prices = [CoffeeSize: Float]()
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
