//
//  CoffeeDetailsView.swift
//  automatic-grammar-agreement-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI

struct CoffeeDetailsView: View {
    
    /// Private properties
    let drink: Drink
    /// State properties
    @State private var quantity = 1
    @State private var selectedSize: CoffeeSize = .regular
    @State private var finalPrice: Float = 0.0
    /// Binding properties
    @Binding var isPresented: Bool
    @Binding var order: Order
    
    init(drink: Drink, order: Binding<Order>, isPresented: Binding<Bool>) {
        self.drink = drink
        self._order = order
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(drink.name)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Text("$\(String(format: "%.1f", finalPrice))")
                    .font(.system(size: 24, weight: .semibold))
            }
            Text("Size")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
            HStack(alignment: .bottom) {
                ForEach(CoffeeSize.allCases, id: \.self) { size in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.brown)
                        .opacity(selectedSize == size ? 1 : 0.2)
                        .frame(height: 180)
                        .overlay {
                            VStack {
                                Image("coffee_cup")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: getWidth(forSize: size))
                                Text(size.description)
                                    .font(.system(size: 16, weight: selectedSize == size ? .bold : .regular))
                                Text(size.ounces)
                                    .font(.system(size: 12))
                            }
                        }
                        
                    .onTapGesture {
                        selectedSize = size
                        finalPrice = drink.price[selectedSize]!
                    }
                    if size != .large {
                        Spacer()
                    }
                }
            }
            .padding(.init(top: 5, leading: 16, bottom: 0, trailing: 16))
            .frame(maxWidth: .infinity)
            
            HStack {
                Stepper("", value: $quantity, in: 1...5)
                    .labelsHidden()
                Spacer()
                Button("Add \(quantity) \(selectedSize.description) \(drink.name.lowercased())") {
                    order.add(item: .init(drink: drink, size: selectedSize, quantity: quantity))
                    isPresented = false
                }
                .buttonStyle(BrownButton())
            }
            .padding(.top, 16)
            
            Spacer()
        }
        .padding(.top, 30)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity)
        .onChange(of: quantity) { old, new in
            finalPrice = drink.price[selectedSize]! * Float(new)
        }
        .onAppear {
            finalPrice = drink.price[selectedSize]!
        }
    }
}

private extension CoffeeDetailsView {
    
    func getWidth(forSize size: CoffeeSize) -> CGFloat {
        switch size {
        case .small:
            return 50
        case .regular:
            return 70
        case .large:
            return 90
        }
    }
}

#Preview {
    CoffeeDetailsView(
        drink: .cappuccino,
        order: .constant(Order()),
        isPresented: .constant(true)
    )
}
