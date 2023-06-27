//
//  OrderConfirmationView.swift
//  automatic-grammar-agreement-demo
//
//  Created by Bruno Lorenzo on 26/6/23.
//

import SwiftUI

struct OrderConfirmationView: View {
    
    /// Private properties
    private var order: Order
    /// Binding properties
    @Binding var navPath: NavigationPath
    
    init(_ order: Order, _ navPath: Binding<NavigationPath>) {
        self.order = order
        self._navPath = navPath
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView {
                ForEach(order.items, id: \.self) { item in
                    HStack {
                        item.drink.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .cornerRadius(24)
                        VStack {
                            Text("\(item.quantity) \(item.size.description) \(item.drink.name)")
                                .font(.system(size: 18, weight: .semibold))
                            Text("(\(item.size.ounces))")
                        }
                        Spacer()
                        Divider()
                            .frame(height: 100)
                        Text("$\(String(format: "%.1f", item.price))")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.trailing, 16)
                        
                    }
                    .background(Color.brown.opacity(0.1))
                    .cornerRadius(24)
                }
                
                Divider()
                
                HStack {
                    Text("Drinks")
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
                    order.clear()
                    navPath = NavigationPath()
                }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(BrownButton())
                    .background(Color.brown)
                    .clipShape(Capsule())
                
                Spacer()
            }
        }
        .padding(16)
    }
}

#Preview {
    OrderConfirmationView(
        Order(
            items: [
                .init(drink: .latte, size: .regular, quantity: 2),
                .init(drink: .cappuccino, size: .large, quantity: 1),
                .init(drink: .mocha, size: .small, quantity: 1)
            ]
        ), .constant(NavigationPath())
    )
}
