//
//  AppError.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 25/12/23.
//

import Foundation
import HKLogger

struct AppError: Error, Equatable {
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        return lhs.code == rhs.code
    }
    
    let code = UUID()
    let type: LocalizedError
    var userMessage: String {
        return "\(type.failureReason ?? ErrorConstants.defaultError) \n\n \(type.recoverySuggestion ?? ErrorConstants.defaultAction)"
    }
    
    init(type: LocalizedError, debugInfo: String? = nil) {
        self.type = type
        
        guard let debugInfo else { return }
        HKLogger.shared.error(message: debugInfo)
    }
}

