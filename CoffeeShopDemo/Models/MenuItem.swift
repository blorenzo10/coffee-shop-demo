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
    
    func localizeDescription(describing menuItem: AnyMenuItem) -> AttributedString {
        var options = AttributedString.LocalizationOptions()
        options.concepts = [.localizedPhrase(menuItem.name)]
        switch self {
        case .small:
            return AttributedString(localized: "Small", options: options)
        case .regular:
            return AttributedString(localized: "Regular", options: options)
        case .large:
            return AttributedString(localized: "Large", options: options)
        }
    }
}

protocol MenuItemInfo: Identifiable {
    typealias Price = [MenuItemSize: Float]
    var name: String { get }
    var localizeDescription: AttributedString? { get }
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
    private let itemType: any MenuItemInfo.Type
    private let _name: String
    private let _localizeDescription: AttributedString?
    private let _thumbnail: Image
    private let _icon: Image
    private let _availableSizes: [MenuItemSize]
    private let _sizeDescriptions: [MenuItemSize: String]?
    private let _price: Price
    
    init<T: MenuItemInfo>(_ item: T) {
        self.itemType = T.self
        self._name = item.name
        self._localizeDescription = item.localizeDescription
        self._thumbnail = item.thumbnail
        self._icon = item.icon
        self._availableSizes = item.availableSizes
        self._sizeDescriptions = item.sizeDescriptions
        self._price = item.price
    }
    
    var name: String { _name }
    var localizeDescription: AttributedString? { _localizeDescription }
    var thumbnail: Image { _thumbnail }
    var icon: Image { _icon }
    var availableSizes: [MenuItemSize] { _availableSizes }
    var sizeDescriptions: [MenuItemSize: String]? { _sizeDescriptions }
    var price: Price { _price }
    
    func isType<T: MenuItemInfo>(_ type: T.Type) -> Bool {
        return itemType == type
    }
}


struct Menu {
    
    var items: [Section: [any MenuItemInfo]]
    var allItems: [any MenuItemInfo] {
        let coffee = getItems(for: .coffee)
        let food = getItems(for: .food)
        return coffee + food
    }
    init() {
        items = [Section: [any MenuItemInfo]]()
        items[.coffee] = [
            Coffee.latte,
            Coffee.cappuccino,
            Coffee.cortado,
            Coffee.flatwhite,
        ]
        items[.food] = [
            Food.croissant,
            Food.hamAndCheeseCroissant,
            Food.chickenSandwich,
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
                return String(localized: "Coffee")
            case .food:
                return String(localized: "Food")
            }
        }
    }
}
