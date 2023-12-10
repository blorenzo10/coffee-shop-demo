//
//  LastOrderView.swift
//  Coffee Shop WidgetExtension
//
//  Created by Bruno Lorenzo on 5/12/23.
//

import SwiftUI

struct LastOrderView: View {
    let order: CoffeeOrder
    
    init(_ order: CoffeeOrder) {
        self.order = order
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("10 coffees = 1 free")
                .font(.system(size: 12, weight: .ultraLight))
            HStack {
                HStack {
                    Text("\(order.coffees)")
                        .font(.system(size: 32, weight: .heavy))
                        .contentTransition(.numericText(value: Double(order.coffees)))
                    Text("/10")
                        .font(.system(size: 32, weight: .heavy))
                }
                Spacer()
                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 24))
            }
            Text("Your last coffee")
                .font(.system(size: 9, weight: .bold))
            Text(order.lastCoffee)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .font(.system(size: 16, weight: .thin))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            Button(intent: RepeatOrderIntent()) {
                Label("Repeat", systemImage: "plus")
                    .font(.caption)
            }
            .tint(Color.black)
            .foregroundColor(.white)
        }
        .containerBackground(for: .widget) {
            Color.widgetBackground.opacity(0.5)
        }
    }
}
