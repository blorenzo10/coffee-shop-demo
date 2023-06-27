//
//  ContentView.swift
//  automatic-grammar-agreement-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI

struct HomeView: View {
    
    /// Private properties
    private let columns = [GridItem(), GridItem()]
    /// State properties
    @State private var showingCoffeeDetails = false
    @State private var selectedDrink: Drink = .latte
    @State private var orderPrice: Float = 0.0
    @State private var order = Order()
    @State private var navPath = NavigationPath()
    
    init() {}
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(Drink.allCases, id: \.self) { drink in
                        VStack(alignment: .leading) {
                            drink.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 180)
                                .cornerRadius(12)
                            Spacer()
                            Text(drink.name)
                                .font(.system(size: 18, weight: .bold))
                                .padding(12)
                        }
                        .background(Color.brown.opacity(0.4))
                        .cornerRadius(12)
                        .padding(10)
                        .onTapGesture {
                            selectedDrink = drink
                            showingCoffeeDetails = true
                        }
                    }
                })
                Button("View my order & checkout") { navPath.append(order) }
                    .buttonStyle(BrownButton())
                    .frame(maxWidth: .infinity)
                    .background(Color.brown)
                    .clipShape(Capsule())
                    .padding(16)
            }
            .navigationDestination(for: Order.self) { order in
                OrderConfirmationView(order, $navPath)
                    .navigationTitle("My Order")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarBackButtonHidden()
            }
        }
        .sheet(isPresented: $showingCoffeeDetails, content: {
            CoffeeDetailsView(drink: selectedDrink, order: $order, isPresented: $showingCoffeeDetails)
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(24)
        })
    }
}
                

#Preview {
    HomeView()
}
