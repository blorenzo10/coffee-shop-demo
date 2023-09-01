//
//  ContentView.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI

struct HomeView: View {
    
    /// Private properties
    private let columns = [GridItem(), GridItem()]
    private let menu = Menu()
    /// State properties
    @State private var showingCoffeeDetails = false
    @State private var selectedItem: AnyMenuItem? = nil
    @State private var orderPrice: Float = 0.0
    @State private var order = Order()
    @State private var navPath = NavigationPath()
    
    init() {}
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                ForEach(Menu.Section.allCases, id: \.self) { menuSection in
                    LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(menu.getItems(for: menuSection), id: \.id) { item in
                                VStack(alignment: .leading) {
                                    item.thumbnail
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 180, height: 180)
                                        .cornerRadius(12)
                                    Spacer()
                                    Text(item.name)
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(12)
                                }
                                .background(Color.brown.opacity(0.4))
                                .cornerRadius(12)
                                .padding(10)
                                .onTapGesture {
                                    selectedItem = AnyMenuItem(item)
                                }
                            }
                        } header: {
                            headerView(title: menuSection.name)
                        }
                    }
                    
                }
                
                Button("View my order & checkout") { navPath.append(order) }
                    .buttonStyle(BrownButton())
                    .frame(maxWidth: .infinity)
                    .background(Color.brown)
                    .clipShape(Capsule())
                    .padding(16)
            }
            .padding(.top, 10)
            .sheet(item: $selectedItem, content: { selectedItem in
                MenuDetailsView(item: selectedItem, order: $order)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(24)
            })
            .navigationDestination(for: Order.self) { order in
                OrderConfirmationView(order, $navPath)
                    .navigationTitle("My Order")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}


extension HomeView {
    
    func headerView(title: String) -> some View {
        return HStack {
            Text(title)
                .font(.title)
                .padding(.leading, 16)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(Color.white)
    }
    
}

#Preview {
    HomeView()
}
