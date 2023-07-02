//
//  MenuItem.swift
//  demo-app
//
//  Created by Bruno Lorenzo on 29/6/23.
//

import Foundation
import SwiftUI

enum MenuItemSize: CaseIterable, Hashable {
    case small
    case regular
    case large
    
    var description: String {
        switch self {
        case .small:
            return String(localized: "Small")
        case .regular:
            return String(localized: "Regular")
        case .large:
            return String(localized: "Large")
        }
    }
}

protocol MenuItemInfo: Identifiable {
    typealias Price = [MenuItemSize: Float]
    var name: String { get }
    var thumbnail: Image { get }
    var icon: Image { get }
    var availableSizes: [MenuItemSize] { get }
    var sizeDescriptions: [MenuItemSize: String]? { get }
    var price: Price { get }
}

extension MenuItemInfo {
    var id: UUID { return UUID() }
}

struct AnyMenuItem: MenuItemInfo {
    private let _name: String
    private let _thumbnail: Image
    private let _icon: Image
    private let _availableSizes: [MenuItemSize]
    private let _sizeDescriptions: [MenuItemSize: String]?
    private let _price: Price
    
    init<T: MenuItemInfo>(_ item: T) {
        self._name = item.name
        self._thumbnail = item.thumbnail
        self._icon = item.icon
        self._availableSizes = item.availableSizes
        self._sizeDescriptions = item.sizeDescriptions
        self._price = item.price
    }
    
    var name: String { _name }
    var thumbnail: Image { _thumbnail }
    var icon: Image { _icon }
    var availableSizes: [MenuItemSize] { _availableSizes }
    var sizeDescriptions: [MenuItemSize: String]? { _sizeDescriptions }
    var price: Price { _price }
}


struct Menu {
    
    var items: [Section: [any MenuItemInfo]]
    
    init() {
        items = [Section: [any MenuItemInfo]]()
        items[.coffee] = [
            Coffee.latte,
            Coffee.cappuccino,
            Coffee.mocha,
            Coffee.flatwhite,
        ]
        items[.food] = [
            Food.croissant,
            Food.chocolateCroissant,
            Food.hamAndCheeseCroissant,
            Food.muffin,
        ]
    }
    
    func getItems(for section: Section) -> [any MenuItemInfo] {
        return items[section] ?? []
    }
}

extension Menu {
    enum Section: CaseIterable {
        case coffee
        case food
        
        var name: String {
            switch self {
            case .coffee:
                return "Coffee"
            case .food:
                return "Food"
            }
        }
    }
}
