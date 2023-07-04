//
//  Food.swift
//  demo-app
//
//  Created by Bruno Lorenzo on 29/6/23.
//

import Foundation
import SwiftUI

enum Food: MenuItemInfo {
    case croissant
    case hamAndCheeseCroissant
    case chickenSandwich
    case muffin
    
    var name: String {
        switch self {
        case .croissant:
            return String(localized: "Croissant")
        case .hamAndCheeseCroissant:
            return String(localized: "Ham & Cheese Croissant")
        case .chickenSandwich:
            return String(localized: "Chicken Sandwich")
        case .muffin:
            return String(localized: "Muffin")
        }
    }
    
    var localizeDescription: AttributedString? {
        switch self {
        case .croissant, .hamAndCheeseCroissant, .chickenSandwich:
            return AttributedString(localized: "Our \(name) is freshly baked")
        case .muffin:
            return nil
        }
    }
    
    var thumbnail: Image {
        switch self {
        case .croissant:
            return Image("croissant")
        case .hamAndCheeseCroissant:
            return Image("hamandcheese-croissant")
        case .chickenSandwich:
            return Image("chicken-sandwich")
        case .muffin:
            return Image("muffin")
        }
    }
    
    var icon: Image {
        switch self {
        case .croissant, .hamAndCheeseCroissant:
            return Image("croissant_icon")
        case .chickenSandwich:
            return Image("sandwich_icon")
        case .muffin:
            return Image("muffin_icon")
        }
    }
    
    var availableSizes: [MenuItemSize] {
        switch self {
        case .muffin:
            return [.small]
        case .chickenSandwich:
            return [.small, .regular]
        default:
            return [.small, .regular]
        }
    }
    
    var sizeDescriptions: [MenuItemSize : String]? {
        return nil
    }
    
    var price: Price {
        var prices = Price()
        switch self {
        case .muffin:
            prices[.small] = 2.5
        case .croissant:
            prices[.small] = 5.0
            prices[.regular] = 5.5
        case .hamAndCheeseCroissant:
            prices[.small] = 7
            prices[.regular] = 8
        case .chickenSandwich:
            prices[.small] = 9.5
            prices[.regular] = 12
        }
        return prices
    }
    
}
