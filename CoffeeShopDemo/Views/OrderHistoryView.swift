//
//  OrderHistoryView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 20/9/23.
//

import SwiftUI

struct OrderHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            if OrdersManager.shared.orders.isEmpty {
                Text("You didn't make any orders yet =)")
            } else {
                List {
                    ForEach(OrdersManager.shared.orders, id: \.self) { order in
                        HStack {
                            Text(order.date.formatted(
                                .dateTime.year().day().month())
                            )
                            Spacer()
                            Text("$\(String(format: "%.1f", order.total))")
                            Image(systemName: "arrow.right.circle")
                                .onTapGesture {
                                    router.routeTo(.confirmation(order))
                                }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.popToPrevious()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Home")
                    }
                }
            }
        }
        .onAppear {
            HistoryTip.alreadyDiscovered = true
        }
    }
}

#Preview {
    OrderHistoryView()
}
