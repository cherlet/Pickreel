import UIKit

class ThemeManager {
    static let shared = ThemeManager()
    
    private init() {}
    
    private let isDark = StorageManager.shared.bool(forKey: .isDark)
    var currentTheme: Theme = .light
    
    func applyTheme() {
        switch currentTheme {
        case .light:
            applyLightTheme()
        case .dark:
            applyDarkTheme()
        }
    }
    
    private func applyLightTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        for window in windowScene.windows {
            window.overrideUserInterfaceStyle = .light
        }
        StorageManager.shared.set(false, forKey: .isDark)
    }
    
    private func applyDarkTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        for window in windowScene.windows {
            window.overrideUserInterfaceStyle = .dark
        }
        StorageManager.shared.set(true, forKey: .isDark)
    }
}

enum Theme {
    case light
    case dark
}
