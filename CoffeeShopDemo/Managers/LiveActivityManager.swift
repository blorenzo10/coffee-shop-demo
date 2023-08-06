//
//  LiveActivityManager.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 20/7/23.
//

import Foundation
import ActivityKit

final class LiveActivityManager {
    
    private let orderAttributes: OrderAttributes
    private var orderActivity: Activity<OrderAttributes>?
    static let shared = LiveActivityManager()
    
    private init() {
        orderAttributes = OrderAttributes(orderNumber: 1)
        
        let initialState = OrderAttributes.ContentState(status: .inQueue)
        let content = ActivityContent(state: initialState, staleDate: nil, relevanceScore: 1.0)

        do {
            orderActivity = try Activity.request(
                attributes: orderAttributes,
                content: content,
                pushType: nil
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func simulate() {
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            print("About to take order")
            await updateActivity(to: .init(status: .aboutToTake))
            try await Task.sleep(nanoseconds: 2_000_000_000)
            print("Making order")
            await updateActivity(to: .init(status: .making))
            try await Task.sleep(nanoseconds: 2_000_000_000)
            print("Order ready")
            await updateActivity(to: .init(status: .ready))
        }
    }
    
    private func updateActivity(to state: OrderAttributes.ContentState) async {
        if state.status == .ready {
            await orderActivity?.end(
                ActivityContent(state: state, staleDate: nil),
                dismissalPolicy: .default
            )
        } else {
            await orderActivity?.update(
                ActivityContent<OrderAttributes.ContentState>(
                    state: state,
                    staleDate: nil
                )
            )
        }
    }
}

