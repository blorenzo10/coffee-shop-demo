//
//  NetworkErrors.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 2/1/24.
//

import Foundation

enum NetworkErrors: LocalizedError {
    case invalidURL(_ url: URL)
    case apiError(statusCode: Int)
    
    var failureReason: String? {
        switch self {
        default:
            "We had problems with our servers"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        default:
            "Please, try again in a few moments"
        }
    }
}
