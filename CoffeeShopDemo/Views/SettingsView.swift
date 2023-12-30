//
//  SettingsView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 17/12/23.
//

import SwiftUI

struct SettingsView: View {
    /// State properties
    @State private var selectedIcon: AppIcon = .default
    
    var body: some View {
        Form {
            Section(
                header: Text("App Icon").font(.headline),
                footer: Text("You can customize the app icon to fit in with your home theme")
            ) {
                ForEach(AppIcon.allCases, id: \.self) { appIcon in
                    Toggle(isOn: Binding(
                        get: { selectedIcon == appIcon },
                        set: { newValue in
                            if newValue {
                                selectedIcon = appIcon
                                updateIcon()
                            }
                        }
                    ), label: {
                        HStack {
                            appIcon.icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text(appIcon.description)
                                .font(.title3)
                        }
                    })
                    .tint(Color.accentColor)
                }
            }
        }
        .onAppear {
            getCurrentIcon()
        }
    }
}

// MARK: - Helpers
private extension SettingsView {
    func getCurrentIcon() {
        if let iconName = UIApplication.shared.alternateIconName {
            selectedIcon = AppIcon(from: iconName)
        } else {
            selectedIcon = .default
        }
    }
    
    func updateIcon() {
        Task {
            await CommonUtils.updateAppIcon(with: selectedIcon.name)
        }
    }
}

#Preview {
    SettingsView()
}
