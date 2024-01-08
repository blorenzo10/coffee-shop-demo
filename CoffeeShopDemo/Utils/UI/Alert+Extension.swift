//
//  Alert+Extension.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 30/12/23.
//

import Foundation
import SwiftUI

extension View {
    func alert(isPresented: Binding<Bool>, withError error: AppError?) -> some View {
        return alert(
            "Ups! :(",
            isPresented: isPresented,
            actions: {
                Button("Ok") {}
            }, message: {
                Text(error?.userMessage ?? "")
            }
        )
    }
}
