//
//  MenuDetailsView.swift
//  demo-app
//
//  Created by Bruno Lorenzo on 2/7/23.
//

import SwiftUI

struct MenuDetailsView: View {
    
    // Private properties
    let item: AnyMenuItem
    /// Environment properties
    @Environment(\.dismiss) var dismiss
    /// State properties
    @State private var quantity = 1
    @State private var selectedSize: MenuItemSize = .small {
        didSet {
            quantity = 1
        }
    }
    @State private var finalPrice: Float = 0.0
    /// Binding properties
    @Binding var order: Order
    
    init(item: AnyMenuItem, order: Binding<Order>) {
        self.item = item
        self._order = order
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(item.name)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Text("$\(String(format: "%.1f", finalPrice))")
                    .font(.system(size: 24, weight: .semibold))
            }
            Text("Size")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
            HStack(alignment: .bottom) {
                ForEach(item.availableSizes, id: \.self) { size in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.brown)
                        .opacity(selectedSize == size ? 1 : 0.2)
                        .frame(height: 180)
                        .overlay {
                            VStack {
                                item.icon
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: getWidth(forSize: size))
                                Text(size.description)
                                    .font(.system(size: 16, weight: selectedSize == size ? .bold : .regular))
                                Text(item.sizeDescriptions?[size] ?? "")
                                    .font(.system(size: 12))
                            }
                        }
                        
                    .onTapGesture {
                        selectedSize = size
                        finalPrice = item.price[selectedSize]!
                    }
                    if size != .large {
                        Spacer()
                    }
                }
            }
            .padding(.init(top: 5, leading: 16, bottom: 16, trailing: 16))
            .frame(maxWidth: .infinity)
            
            HStack {
                Spacer()
                Stepper("Cantidad", value: $quantity, in: 1...5)
                    .labelsHidden()
                Spacer()
            }

            Button("Add \(quantity) \(selectedSize.description) \(item.name.lowercased())") {
                order.add(item: .init(item: item, size: selectedSize, quantity: quantity))
                dismiss()
            }
            .buttonStyle(BrownButton())
            .frame(maxWidth: .infinity)
            .background(Color.brown)
            .clipShape(Capsule())
            .padding(.top, 16)
            
            Spacer()
        }
        .padding(.top, 30)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity)
        .onChange(of: quantity) { old, new in
            finalPrice = item.price[selectedSize]! * Float(new)
        }
        .onAppear {
            finalPrice = item.price[selectedSize]!
        }
    }
}

private extension MenuDetailsView {
    
    func getWidth(forSize size: MenuItemSize) -> CGFloat {
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
    MenuDetailsView(
        item: AnyMenuItem(Food.croissant),
        order: .constant(Order())
    )
}
