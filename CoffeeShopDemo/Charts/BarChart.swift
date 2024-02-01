//
//  BarChart.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 21/1/24.
//

import SwiftUI
import Charts

struct BarChart: View {
    @State private var data = DemoCoffeeData.mockData()
    
    var body: some View {
        Chart(data) {
            AreaMark(
                x: .value("Date", $0.date),
                y: .value("Coffee", $0.coffee)
            )
            .cornerRadius(12)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .month, count: 1)) { _ in
                AxisValueLabel(format: .dateTime.month(.abbreviated).year(.twoDigits), centered: false)
            }
        }
        .chartYScale(domain: 0 ... 30)
        .frame(height: 300)
        .padding(.horizontal, 48)
    }
}

#Preview {
    BarChart()
}
