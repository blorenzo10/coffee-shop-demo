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
    case chocolateCroissant
    case hamAndCheeseCroissant
    case muffin
    
    var name: String {
        switch self {
        case .croissant:
            return String(localized: "Croissant")
        case .chocolateCroissant:
            return String(localized: "Chocolate Croissant")
        case .hamAndCheeseCroissant:
            return String(localized: "Ham & Cheese Croissant")
        case .muffin:
            return String(localized: "Muffin")
        }
    }
    
    var thumbnail: Image {
        switch self {
        case .croissant:
            return Image("croissant")
        case .chocolateCroissant:
            return Image("chocolate-croissant")
        case .hamAndCheeseCroissant:
            return Image("hamandcheese-croissant")
        case .muffin:
            return Image("muffin")
        }
    }
    
    var icon: Image {
        switch self {
        case .croissant, .chocolateCroissant, .hamAndCheeseCroissant:
            return Image("croissant_icon")
        case .muffin:
            return Image("muffin_icon")
        }
    }
    
    var availableSizes: [MenuItemSize] {
        switch self {
        case .muffin:
            return [.small]
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
        case .chocolateCroissant:
            prices[.small] = 5.5
            prices[.regular] = 6
        case .hamAndCheeseCroissant:
            prices[.small] = 7
            prices[.regular] = 8
        }
        return prices
    }
    
}
