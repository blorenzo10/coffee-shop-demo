//
//  DummyData.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 21/1/24.
//

import Foundation

struct DemoCoffeeData: Identifiable {
    let date: Date
    let coffee: Int
    
    var id: Date { date }
    
    static func mockData() -> [DemoCoffeeData] {
        return [
            .init(date: Date(year: 2023, month: 09), coffee: 18),
            .init(date: Date(year: 2023, month: 10), coffee: 12),
            .init(date: Date(year: 2023, month: 11), coffee: 27),
            .init(date: Date(year: 2023, month: 12), coffee: 15),
            .init(date: Date(year: 2024, month: 01), coffee: 24),
        ]
    }
}
