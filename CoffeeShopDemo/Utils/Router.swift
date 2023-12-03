//
//  Router.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 21/9/23.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    
    enum Destination: Hashable {
        case confirmation(_ order: Order)
        case history
        case map
    }
    
    @Published var navPath = NavigationPath()
        
    func routeTo(_ destination: Destination) {
        navPath.append(destination)
    }
    
    func popToPrevious() {
        navPath.removeLast()
    }
    
    func popScreens(_ amount: Int) {
        navPath.removeLast(amount)
    }
    
    func popToRoot() {
        navPath = NavigationPath()
    }
}
