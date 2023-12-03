//
//  CircleButton.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 18/11/23.
//

import SwiftUI

struct CircleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 24, height: 24)
            .foregroundColor(.white)
            .background(.black.opacity(0.4))
            .clipShape(Circle())
    }
}
