//
//  ContentView.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI
import TipKit

struct HomeView: View {
    @AppStorage("showedUpdateIconView") var updateIconDidShow: Bool = false
    /// Environment properties
    @EnvironmentObject var router: Router
    /// State properties
    @State private var showingCoffeeDetails = false
    @State private var showUpdateIconView = false
    @State private var showingMap = false
    @State private var selectedItem: AnyMenuItem? = nil
    @State private var orderPrice: Float = 0.0
    @State private var order = Order()
    /// Private properties
    private let columns = [GridItem(), GridItem()]
    private let menu = Menu()
    private let tip = HistoryTip()
    
    var body: some View {
        HStack {
            Text("Menu")
                .font(.largeTitle)
            Spacer()
            Button {
                router.routeTo(.map)
            } label: {
                Image(systemName: "map.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
            Button {
                router.routeTo(.history)
            } label : {
                Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                
            }
            .popoverTip(tip)
            .onTapGesture {
                tip.invalidate(reason: .actionPerformed)
            }
        }
        .padding(.horizontal, 16)
        
        ScrollView {
            ForEach(Menu.Section.allCases, id: \.self) { menuSection in
                Section {
                    ForEach(menu.getItems(for: menuSection), id: \.id) { item in
                        VStack(alignment: .leading) {
                            item.thumbnail
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 180)
                                .cornerRadius(12)
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
            
            Button("View my order & checkout") {
                router.routeTo(.confirmation(order))
            }
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
        .fullScreenCover(isPresented: $showUpdateIconView, content: {
            IconAnimationView()
        })
        .onReceive(NotificationCenter.default.publisher(for: .clearOrder)) { _ in
            order = Order()
        }
        .onAppear {
            checkVersion()
        }
    }
}

// MARK: - UI Components
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

// MARK: - Helpers
private extension HomeView {
    func checkVersion() {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            fatalError("CFBundleShortVersionString should not be missing from info dictionary")
        }
        if version != "1.0.0" {
            if !updateIconDidShow {
                showUpdateIconView = true
                updateIconDidShow = true
            }
        }
    }
}

#Preview {
    HomeView()
}
