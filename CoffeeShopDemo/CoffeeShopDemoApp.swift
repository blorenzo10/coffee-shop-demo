//
//  automatic_grammar_agreement_demoApp.swift
//  automatic-grammar-agreement-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI

@main
struct CoffeeShopDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
