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
            await updateActivity(to: .init(currentOrder: 5))
            try await Task.sleep(nanoseconds: 1_000_000_000)
            await updateActivity(to: .init(currentOrder: 6))
            try await Task.sleep(nanoseconds: 1_000_000_000)
            await updateActivity(to: .init(currentOrder: 7))
            print("About to take order")
            await updateActivity(to: .init(status: .aboutToTake, currentOrder: 8))
            try await Task.sleep(nanoseconds: 1_000_000_000)
            print("Making order")
            await updateActivity(to: .init(status: .making, currentOrder: 8))
            try await Task.sleep(nanoseconds: 1_000_000_000)
            print("Order ready")
            await updateActivity(to: .init(status: .ready, currentOrder: 8))
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await orderActivity?.end(
                ActivityContent(state: OrderAttributes.ContentState.init(status: .ready, currentOrder: 8), staleDate: nil),
                dismissalPolicy: .default
            )
            orderActivity = nil
        }
    }
    
    private func updateActivity(to state: OrderAttributes.ContentState) async {
        var alert: AlertConfiguration?
        if state.status == .ready {
            alert = AlertConfiguration(
                title: "\(state.status.description)",
                body: "",
                sound: .default
            )
        }
        await orderActivity?.update(
            ActivityContent<OrderAttributes.ContentState>(
                state: state,
                staleDate: nil
            ),
            alertConfiguration: alert
        )
    }
}

