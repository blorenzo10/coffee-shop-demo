//
//  AppDelegate.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 20/7/23.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        if CommandLine.arguments.contains("-ui-test") {
            resetToDefaultState()
        }
        #endif
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App about to enter background")
    }
}

extension AppDelegate {
    func resetToDefaultState() {
        
    }
}
