//
//  automatic_grammar_agreement_demoApp.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI
import TipKit

@main
struct CoffeeShopDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        try? Tips.resetDatastore()
        try? Tips.configure([
            .displayFrequency(.immediate)
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContainerView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
