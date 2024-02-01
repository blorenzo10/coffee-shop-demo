//
//  DemoChart.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 21/1/24.
//

import SwiftUI
import Charts

struct DemoChart: View {
    @Environment(\.calendar) var calendar
    @State private var coffeeData = CoffeeData.mockData()
    @State private var overallData = OverallData.mockData()
    @State private var chartSelection: Date?
    
    private var areaBackground: Gradient {
        return Gradient(colors: [Color.accentColor, Color.accentColor.opacity(0.1)])
    }
    var body: some View {
        Chart(overallData) {
            LineMark(
                x: .value("Month", $0.date, unit: .month),
                y: .value("Amount", $0.coffee)
            )
            .symbol(.circle)
            .interpolationMethod(.catmullRom)
            
            if let chartSelection {
                RuleMark(x: .value("Month", chartSelection, unit: .month))
                    .foregroundStyle(.gray.opacity(0.5))
                    .annotation(
                        position: .top,
                        overflowResolution: .init(x: .fit, y: .disabled)
                    ) {
                        ZStack {
                            Text("\(getCoffee(for: chartSelection)) coffees")
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(Color.accentColor.opacity(0.2))
                        }
                    }
            }
            
            AreaMark(
                x: .value("Month", $0.date, unit: .month),
                y: .value("Amount", $0.coffee)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(areaBackground)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .month, count: 1)) { _ in
                AxisValueLabel(format: .dateTime.month(.abbreviated).year(.twoDigits), centered: true)
            }
        }
        .chartYScale(domain: 0 ... 30)
        .frame(height: 300)
        .padding()
        .chartXSelection(value: $chartSelection)
        
        
        
//        Chart {
//            ForEach(coffeeData, id: \.id) { coffeeInfo in
//                ForEach(coffeeInfo.details, id: \.type) { coffeeDetails in
//                    BarMark(
//                        x: .value("Date", coffeeInfo.date, unit: .month),
//                        y: .value("Coffee", coffeeDetails.amount)
//                    )
//                    .annotation(position: .top, alignment: .center) {
//                        Text("\(coffeeDetails.amount)")
//                    }
//                    .foregroundStyle(by: .value("Coffee Type", coffeeDetails.type))
//                    .position(by: .value("Coffee Type", coffeeDetails.type))
//                    .cornerRadius(12)
//                }
//            }
//        }
//        .chartForegroundStyleScale([
//            Coffee.latte: Color.accentColor,
//            Coffee.cappuccino: Color.accentColor.opacity(0.7),
//            Coffee.cortado: Color.accentColor.opacity(0.5),
//            Coffee.flatwhite: Color.accentColor.opacity(0.3),
//        ])
//        .chartXAxis {
//            AxisMarks(values: .stride(by: .month, count: 1)) { _ in
//                AxisValueLabel(format: .dateTime.month(.abbreviated).year(.twoDigits), centered: true)
//            }
//        }
//        .chartScrollableAxes(.horizontal)
//        .chartYScale(domain: 0 ... 15)
//        .frame(height: 300)
//        .padding()
    }
    
    func totalCoffees(in details: [CoffeeData.CoffeeDetails]) -> Int {
        return details.map({$0.amount}).reduce(0, +)
    }
    
    func getCoffee(for date: Date) -> Int {
        return overallData.first(where: { calendar.isDate($0.date, equalTo: date, toGranularity: .month) })?.coffee ?? 0
    }
}

#Preview {
    DemoChart()
}
