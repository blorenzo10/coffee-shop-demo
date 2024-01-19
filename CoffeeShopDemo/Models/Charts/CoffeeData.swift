//
//  CoffeeData.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 18/1/24.
//

import Foundation

struct CoffeeData: Identifiable {
    typealias CoffeeDetails = (type: Coffee, amount: Int)
    let id = UUID()
    let date: Date
    let details: [CoffeeDetails]
    
    var min: Int {
        return details.map({ $0.amount }).min() ?? 0
    }
    
    var max: Int {
        return details.map({ $0.amount }).max() ?? 0
    }
    
    static func mockData() -> [CoffeeData] {
        return [
            CoffeeData(
                date: Date(year: 2023, month: 08),
                details: [
                    CoffeeDetails(type: .latte, amount: 10),
                    CoffeeDetails(type: .cappuccino, amount: 3),
                    CoffeeDetails(type: .cortado, amount: 3),
                    CoffeeDetails(type: .flatwhite, amount: 2),
                ]
            ),
            CoffeeData(
                date: Date(year: 2023, month: 09),
                details: [
                    CoffeeDetails(type: .latte, amount: 6),
                    CoffeeDetails(type: .cappuccino, amount: 4),
                    CoffeeDetails(type: .cortado, amount: 3),
                    CoffeeDetails(type: .flatwhite, amount: 2),
                ]
            ),
            CoffeeData(
                date: Date(year: 2023, month: 10),
                details: [
                    CoffeeDetails(type: .latte, amount: 3),
                    CoffeeDetails(type: .cappuccino, amount: 2),
                    CoffeeDetails(type: .cortado, amount: 1),
                    CoffeeDetails(type: .flatwhite, amount: 1),
                ]
            ),
            CoffeeData(
                date: Date(year: 2023, month: 11),
                details: [
                    CoffeeDetails(type: .latte, amount: 8),
                    CoffeeDetails(type: .cappuccino, amount: 3),
                    CoffeeDetails(type: .cortado, amount: 4),
                    CoffeeDetails(type: .flatwhite, amount: 3),
                ]
            ),
            CoffeeData(
                date: Date(year: 2023, month: 12),
                details: [
                    CoffeeDetails(type: .latte, amount: 7),
                    CoffeeDetails(type: .cappuccino, amount: 3),
                    CoffeeDetails(type: .cortado, amount: 1),
                    CoffeeDetails(type: .flatwhite, amount: 3),
                ]
            ),
            CoffeeData(
                date: Date(year: 2024, month: 01),
                details: [
                    CoffeeDetails(type: .latte, amount: 4),
                    CoffeeDetails(type: .cappuccino, amount: 4),
                    CoffeeDetails(type: .cortado, amount: 5),
                    CoffeeDetails(type: .flatwhite, amount: 2),
                ]
            )
        ]
    }
}
