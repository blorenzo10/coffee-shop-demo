//
//  OrderError.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 31/12/23.
//

import Foundation

enum OrderError: LocalizedError {
    case unexpected
    case outOfCoffee(coffee: Coffee)
    case minimumNotMet(currentPrice: Float)
    
    var failureReason: String? {
        switch self {
        case .unexpected:
            return "We had an error when confirming your order"
        case .outOfCoffee(let coffee):
            return "We ran out of \(coffee.name)"
        case .minimumNotMet:
            return "You need to reach at least $10 to order from the app"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .unexpected:
            return "Try again in a few minutes"
        case .outOfCoffee:
            return "Change your coffee for another one"
        case .minimumNotMet(let currentPrice):
            return "Add \(10-currentPrice) to your order"
        }
    }
}
