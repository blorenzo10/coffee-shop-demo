//
//  Common.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 17/12/23.
//

import Foundation
import SwiftUI

@MainActor
class CommonUtils {
    
    static func updateAppIcon(with iconName: String?) async {
        Task {
            do {
                guard UIApplication.shared.alternateIconName != iconName else {
                    return
                }
                try await UIApplication.shared.setAlternateIconName(iconName)
            } catch {
                print("Could not update icon \(error.localizedDescription)")
            }
        }
    }
}
