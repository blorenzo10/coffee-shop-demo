//
//  ContentView.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI
import TipKit
import OpenAPIRuntime
import OpenAPIURLSession

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
    @State private var specialOffers = [Components.Schemas.SpecialOffer]()
    @State private var order = Order()
    /// Private properties
    private let columns = [GridItem(), GridItem()]
    private let menu = Menu()
    private let tip = HistoryTip()
    private var apiClient = ApiClient()
    
    var body: some View {
        HStack {
            Text("Coffee Shop")
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
            .accessibilityIdentifier("MapButton")
            Button {
                router.routeTo(.history)
            } label : {
                Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                
            }
            .accessibilityIdentifier("HistoryButton")
            .popoverTip(tip)
            .onTapGesture {
                tip.invalidate(reason: .actionPerformed)
            }
        }
        .padding(.horizontal, 16)
        ScrollView {
            VStack(alignment: .leading) {
                Text("Today's offers")
                    .font(.title)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(specialOffers, id: \.self) { offer in
                            VStack {
                                Coffee.latte.thumbnail
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 80)
                                    .clipped()
                                
                                Text(offer.name ?? "")
                                    .font(.headline)
                                    .padding(.top, 4)
                                
                                Text(offer.description ?? "")
                                    .font(.footnote)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 2)
                                    .padding(.horizontal, 6)
                                Spacer()
                                HStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.clear)
                                        .stroke(Color.accentColor, lineWidth: 2)
                                        .overlay {
                                            Text("$\(String(format: "%.1f", offer.price ?? 0))")
                                                .font(.headline)
                                        }
                                        .padding(6)
                                    
                                    Button("+") {}
                                        .frame(width: 50,  height: 30)
                                        .font(.system(size: 16, weight: .semibold))
                                        .background(Color.accentColor)
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .padding(6)
                                    
                                }
                                .frame(height: 40)
                            }
                            .frame(width: 230, height: 200)
                            .background(Color.accentColor.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .padding()
            
            
            ForEach(Menu.Section.allCases, id: \.self) { menuSection in
                Section {
                    ForEach(menu.getItems(for: menuSection), id: \.id) { item in
                        VStack(alignment: .leading) {
                            item.thumbnail
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 180)
                                .cornerRadius(12)
                                .accessibilityIdentifier(item.name)
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
            .accessibilityIdentifier(Identifiers.Buttons.CHECKOUT)
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
            Task {
                do {
                    specialOffers = try await apiClient.getSpecialOffers()
                } catch {
                    print(error)
                }
            }
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
