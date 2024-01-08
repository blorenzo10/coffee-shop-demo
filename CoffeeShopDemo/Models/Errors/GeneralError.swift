//
//  GeneralError.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 31/12/23.
//

import Foundation

enum GeneralError: LocalizedError {
    case unexpected
    case invalidIconName
    case couldNotUpdateIcon
    
    var failureReason: String? {
        switch self {
        case .unexpected:
            "We had an unexpected error"
        case .invalidIconName:
            "It seems that the App Icon is missing"
        case .couldNotUpdateIcon:
            "We couldn't update the App Icon"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .unexpected:
            return ErrorConstants.defaultAction
        case .invalidIconName:
            return "Try to update the app to the latest version. If the error persists, contact us"
        case .couldNotUpdateIcon:
            return "Try again in a few minutes"
        }
    }
}
