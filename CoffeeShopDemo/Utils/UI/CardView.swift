//
//  CardView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 17/12/23.
//

import SwiftUI

struct CardView: View {
    @Binding var degree: Double
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(color: .gray, radius: 2, x: 0, y: 0)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    CardView(degree: .constant(0), image: Image("AppIcon-Preview"))
}
