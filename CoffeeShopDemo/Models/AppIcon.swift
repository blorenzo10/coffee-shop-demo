//
//  AppIcon.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 17/12/23.
//

import Foundation
import SwiftUI

enum AppIcon: CaseIterable {
    case `default`
    case updateOne
    
    var name: String? {
        switch self {
        case .default:
            return nil
        case .updateOne:
            return "AppIcon-Update-1"
        }
    }
    
    var description: String {
        switch self {
        case .default:
            return "Default"
        case .updateOne:
            return "Update 1"
        }
    }
    
    var icon: Image {
        switch self {
        case .default:
            return Image("AppIcon-Icon")
        case .updateOne:
            return Image("AppIcon-Update-1-Icon")
        }
    }
}

extension AppIcon {
    init(from name: String) {
        switch name {
        case "AppIcon-Update-1": self = .updateOne
        default: self = .default
        }
    }
}
