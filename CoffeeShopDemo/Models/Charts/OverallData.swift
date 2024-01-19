//
//  OverallData.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 18/1/24.
//

import Foundation

struct OverallData: Identifiable {
    let id = UUID()
    let date: Date
    let coffee: Int
    let food: Int
    
    static func mockData() -> [OverallData] {
        
        return [
            .init(date: Date(year: 2023, month: 08), coffee: 12, food: 3),
            .init(date: Date(year: 2023, month: 09), coffee: 15, food: 5),
            .init(date: Date(year: 2023, month: 10), coffee: 8, food: 1),
            .init(date: Date(year: 2023, month: 11), coffee: 18, food: 2),
            .init(date: Date(year: 2023, month: 12), coffee: 14, food: 8),
            .init(date: Date(year: 2024, month: 01), coffee: 22, food: 11),
        ]
    }
}
