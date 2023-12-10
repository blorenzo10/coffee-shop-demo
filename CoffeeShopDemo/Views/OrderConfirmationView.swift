//
//  OrderConfirmationView.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 26/6/23.
//

import SwiftUI

struct OrderConfirmationView: View {
    /// Environment properties
    @EnvironmentObject var router: Router
    /// State properties
    @State private var showingAlert = false
    /// View's properties
    private var order: Order
    
    init(_ order: Order) {
        self.order = order
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(order.items, id: \.id) { item in
                    HStack {
                        item.item.thumbnail
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(24)
                        Spacer()
                        VStack(alignment: .center) {
                            Text("\(item.quantity) \(item.size.localizeDescription(describing: item.item)) \(item.item.name.lowercased())")
                                .font(.system(size: 18, weight: .semibold))
                                .multilineTextAlignment(.center)
                            Text("\(item.item.sizeDescriptions?[item.size] ?? "")")
                                .foregroundStyle(Color.gray)
                        }
                        Spacer()
                        Divider()
                            .frame(height: 100)
                        Text("$\(String(format: "%.1f", item.price))")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.trailing, 16)
                        
                    }
                    .background(Color.brown.opacity(0.1))
                    .cornerRadius(24)
                }
                
                Divider()
                
                HStack {
                    Text("Order")
                    Spacer()
                    Text("$\(String(format: "%.1f", order.price))")
                }
                .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                HStack {
                    Text("Taxes")
                    Spacer()
                    Text("$\(String(format: "%.1f", order.taxes))")
                }
                .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(String(format: "%.1f", order.total))")
                }
                .padding(.init(top: 3, leading: 16, bottom: 12, trailing: 16))
                
                Button("Place Order") {
                    showingAlert = true
                    OrdersManager.shared.add(order)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(BrownButton())
                .background(Color.brown)
                .clipShape(Capsule())
                
                Button("Cancel") {
                    NotificationCenter.default.post(name: .clearOrder, object: nil)
                    router.popToPrevious()
                }
                .padding(.top, 16)
                Spacer()
            }
        }
        .padding(16)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Your order is confirmed!"),
                message: Text("Order number 8"),
                dismissButton: .default(Text("Ok"), action: {
                    NotificationCenter.default.post(name: .clearOrder, object: nil)
                    Task { await HistoryTip.orderPlaced.donate() }
                    router.popToPrevious()
                })
            )
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
    }
}

#Preview {
    OrderConfirmationView(
        Order(
            items: [
                .init(item: AnyMenuItem(Coffee.latte), size: .regular, quantity: 2),
                .init(item: AnyMenuItem(Coffee.cappuccino), size: .large, quantity: 1),
                .init(item: AnyMenuItem(Coffee.cortado), size: .small, quantity: 1),
                .init(item: AnyMenuItem(Food.chickenSandwich), size: .regular, quantity: 2),
            ]
        )
    )
}
