//
//  AppError.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 25/12/23.
//

import Foundation

enum AppError: Error {
    
    enum General {
        case invalidIconName
        case couldNotUpdateIcon(debugMessage: String?)
        
        var debugMessage: String? {
            switch self {
            case .couldNotUpdateIcon(let debugMessage):
                return debugMessage
            default:
                return nil
            }
        }
    }
}

extension AppError.General: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidIconName:
            return "We're sorry :( It seems the new Icon is missing"
        case .couldNotUpdateIcon:
            return "We couldn't update the app's icon :("
        }
    }
}
