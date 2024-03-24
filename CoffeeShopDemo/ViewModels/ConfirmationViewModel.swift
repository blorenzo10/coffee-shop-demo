//
//  ConfirmationViewModel.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 5/1/24.
//

import Foundation
import SwiftUI

@Observable
final class ConfirmationViewModel: ObservableObject {
    var appError: AppError?
    var showError = false
    
    func tryToPlaceOrder(_ order: Order) {
        do {
            try OrdersManager.shared.add(order)
            Task {
                try await ApiClient().placeOrder()
            }
        } catch let error as AppError {
            showError = true
            appError = error
        } catch {
            appError = AppError(type: OrderError.unexpected)
        }
    }
}
