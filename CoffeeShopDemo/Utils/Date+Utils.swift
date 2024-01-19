//
//  Date+Utils.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 14/1/24.
//

import Foundation

extension Date {
    func getComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    init(year: Int, month: Int, day: Int = 1){
        self = Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
    }
}
