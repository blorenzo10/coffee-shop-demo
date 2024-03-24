//
//  Client.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 1/3/24.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

struct ApiClient {
    
    let client: Client
    
    init() {
        client = Client(serverURL: try! Servers.server1(), transport: URLSessionTransport())
    }
    
    func getSpecialOffers() async throws -> [Components.Schemas.SpecialOffer] {
        let client = Client(serverURL: try! Servers.server1(), transport: URLSessionTransport())
        let response = try await client.getSpacialOffers()
        switch response {
        case .ok(let result):
            return try result.body.json
        case .undocumented(statusCode: let statusCode):
            throw AppError(type: NetworkErrors.apiError(statusCode: statusCode.statusCode))
        }
    }
    
    func placeOrder() async throws {
        let response = try await client.placeOrder(Operations.placeOrder.Input(body: .json(.init(id: "1"))))
        switch response {
        case .ok:
            print("Ok")
        case .undocumented(statusCode: let statusCode):
            throw AppError(type: NetworkErrors.apiError(statusCode: statusCode.statusCode))
        }
    }
}
