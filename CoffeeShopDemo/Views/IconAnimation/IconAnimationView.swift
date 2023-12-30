//
//  IconAnimationView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 12/12/23.
//

import SwiftUI

struct IconAnimationView: View {
    /// Enviroment
    @Environment(\.dismiss) var dismiss
    /// State properties
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    /// View's properties
    let durationAndDelay: CGFloat = 0.5
    private var currentAppIcon = AppIcon.default.icon
    private var newAppIcon = AppIcon.updateOne.icon
    private var buttonTitle: String {
        return isFlipped ? "Revert to previous" : "Reveal new icon"
    }
    
    //MARK: View Body
    var body: some View {
        VStack {
            if !isFlipped {
                Text("Update your app's icon with the new one")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.horizontal, 16)
                Text("Pss: you can revert it from the settings tab if you don't like it 😉")
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .horizontal], 16)
            }
            ZStack {
                CardView(degree: $frontDegree, image: newAppIcon)
                CardView(degree: $backDegree, image: currentAppIcon)
            }
            
            if !isFlipped {
                Button(buttonTitle) {
                    flipCard()
                }
                .buttonStyle(BrownButton())
                .background(Color.brown)
                .clipShape(Capsule())
                .padding(.top, 32)
            } else {
                Button("Confirm the change") {
                    updateIcon()
                }
                .buttonStyle(BrownButton())
                .background(Color.brown)
                .clipShape(Capsule())
                .padding(.top, 32)
                
                Button("Revert to original") {
                    dismiss()
                }
            }
        }
    }
}

// MARK: - Helpers
private extension IconAnimationView {
    func flipCard() {
        withAnimation {
            isFlipped.toggle()
        }
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 270
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    func updateIcon() {
        Task {
            await CommonUtils.updateAppIcon(with: "AppIcon-Update-1")
            dismiss()
        }
    }
}

#Preview {
    IconAnimationView()
}
