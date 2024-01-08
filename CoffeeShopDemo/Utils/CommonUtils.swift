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
    
    static func updateAppIcon(with iconName: String?) async throws {
        do {
            guard UIApplication.shared.alternateIconName != iconName else {
                return
            }
            try await UIApplication.shared.setAlternateIconName(iconName)
        } catch {
            throw AppError(type: GeneralError.couldNotUpdateIcon, debugInfo: error.localizedDescription)
        }
    }
}
