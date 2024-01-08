//
//  NetworkErrors.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 2/1/24.
//

import Foundation

enum NetworkErrors: Error {
    case invalidURL(_ url: URL)
    case apiError(statusCode: Int)
}
