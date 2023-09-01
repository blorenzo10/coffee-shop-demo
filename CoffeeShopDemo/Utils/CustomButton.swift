//
//  CustomButton.swift
//  coffee-shop-demo
//
//  Created by Bruno Lorenzo on 25/6/23.
//

import SwiftUI

struct BrownButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.brown)
            .foregroundStyle(.white)
            .font(.system(size: 16, weight: .semibold))
            .clipShape(Capsule())
    }
}
