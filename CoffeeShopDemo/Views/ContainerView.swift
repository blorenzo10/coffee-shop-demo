//
//  ContainerView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 24/9/23.
//

import SwiftUI

struct ContainerView: View {
    
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            HomeView()
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .confirmation(let order):
                        OrderConfirmationView(order)
                            .navigationTitle("My Order")
                            .navigationBarTitleDisplayMode(.large)
                            .navigationBarBackButtonHidden()
                        
                    case .history:
                        OrderHistoryView()
                            .navigationTitle("History")
                            .navigationBarTitleDisplayMode(.large)
                            .navigationBarBackButtonHidden()
                        
                    case .map:
                        MapContainerView()
                            .navigationTitle("")
                            .navigationBarBackButtonHidden()
                    }
                }
        }
        .environmentObject(router)
    }
}
