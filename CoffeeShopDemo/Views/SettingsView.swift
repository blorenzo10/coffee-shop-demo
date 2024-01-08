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
    @State private var presentingErrorAlert = false
    @State private var appError: AppError?
    
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
                                tryToUpdateIcon(with: appIcon)
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
        .alert(isPresented: $presentingErrorAlert, withError: appError)
        .onAppear {
            getCurrentIcon()
        }
        .onChange(of: appError) {
            presentingErrorAlert = appError != nil
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
    
    func tryToUpdateIcon(with icon: AppIcon?) {
        guard let icon else { return }
        Task {
            do {
                try await CommonUtils.updateAppIcon(with: icon.name)
                selectedIcon = icon
            } catch let error as AppError {
                appError = error
                print(error)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    SettingsView()
}
