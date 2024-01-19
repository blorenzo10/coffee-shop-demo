//
//  ChartsView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 13/1/24.
//

import SwiftUI
import Charts

struct CoffeeChart: View {
    /// Environment properties
    @Environment(\.calendar) var calendar
    /// State properties
    @State private var coffeeData = CoffeeData.mockData()
    @State private var overallData = OverallData.mockData()
    @State private var showAverage = false
    @State private var chartSelection: Date?
    /// Private properties
    private var areaBackground: Gradient {
        return showAverage
            ? Gradient(colors: [Color.accentColor.opacity(0.2)])
            : Gradient(colors: [Color.accentColor, Color.accentColor.opacity(0.1)])
    }
    private var averageCoffeeValue: Int = 0
    private var numberOfMonths: Int = 0
    private var lattes: Int = 0
    private var cappuccinos: Int = 0
    private var cortados: Int = 0
    private var flatWhite: Int = 0
    private var coffees: Int = 0
    
    init() {
        let sum = overallData.compactMap({ $0.coffee }).reduce(0, +)
        averageCoffeeValue = sum / overallData.count
        numberOfMonths = coffeeData.count
        let details = coffeeData.compactMap({ $0.details }).flatMap { $0 }
        lattes = details.filter({ $0.type == .latte }).map({ $0.amount }).reduce(0,+)
        cappuccinos = details.filter({ $0.type == .cappuccino }).map({ $0.amount }).reduce(0,+)
        cortados = details.filter({ $0.type == .cortado }).map({ $0.amount }).reduce(0,+)
        flatWhite = details.filter({ $0.type == .flatwhite }).map({ $0.amount }).reduce(0,+)
        coffees = sum
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("Coffee types in the last \(numberOfMonths) months")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Text("\(lattes) lattes")
                        .font(.headline)
                    Text("\(cappuccinos) cappuccinos")
                        .font(.headline)
                    Text("\(cortados) cortados")
                        .font(.headline)
                    Text("\(flatWhite) flat whites")
                        .font(.headline)
                    
                    barChart
                }
            }
            Section {
                VStack(alignment: .leading) {
                    Text("Total coffee ordered")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Text("\(coffees) coffees")
                        .font(.headline)
                    lineChart
                        .padding(.top, 48)
                }
            }
            Section("Options") {
                Toggle("Show Average", isOn: $showAverage)
                    .tint(.accentColor)
            }
        }
    }
}

// MARK: - UI Componentes
private extension CoffeeChart {
    var barChart: some View {
        Chart {
            ForEach(coffeeData, id: \.id) { coffeeData in
                ForEach(coffeeData.details, id: \.type) { coffeeDetails in
                    BarMark(
                        x: .value("Month", coffeeData.date, unit: .month),
                        y: .value("Amount", coffeeDetails.amount)
                    )
                    .annotation(position: .top, alignment: .center) {
                        Text("\(coffeeDetails.amount)")
                    }
                    .foregroundStyle(by: .value("Coffee Type", coffeeDetails.type))
                    .position(by: .value("Coffee Type", coffeeDetails.type))
                    .cornerRadius(12)
                }
            }
        }
        .chartForegroundStyleScale([
            Coffee.latte: Color.accentColor,
            Coffee.cappuccino: Color.accentColor.opacity(0.7),
            Coffee.cortado: Color.accentColor.opacity(0.5),
            Coffee.flatwhite: Color.accentColor.opacity(0.3),
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .month, count: 1)) { _ in
                AxisValueLabel(format: .dateTime.month(.abbreviated).year(.twoDigits), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks {
                AxisValueLabel()
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 3600 * 24 * 30)
        .chartYScale(domain: 0 ... 12)
        .frame(height: 300)
        .padding()
    }
    
    var lineChart: some View {
        Chart(overallData) {
            LineMark(
                x: .value("Month", $0.date, unit: .month),
                y: .value("Amount", $0.coffee)
            )
            .symbol(.circle)
            .interpolationMethod(.catmullRom)
            .foregroundStyle(showAverage ? .accent.opacity(0.1) : .accent)
            
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
            
            if showAverage {
                RuleMark(y: .value("Average", averageCoffeeValue))
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .annotation(position: .top) {
                        Text("\(averageCoffeeValue) coffees on average")
                            .font(.headline)
                            .foregroundStyle(Color.accentColor)
                    }
            }
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
    }
}

// MARK: - Helpers
private extension CoffeeChart {
    func getCoffee(for date: Date) -> Int {
        return overallData.first(where: { calendar.isDate($0.date, equalTo: date, toGranularity: .month) })?.coffee ?? 0
    }
}

#Preview {
    CoffeeChart()
}

