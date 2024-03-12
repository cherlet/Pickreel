import Foundation

// MARK: - CRUD
protocol StorageManagerProtocol {
    func set(_ object: Any?, forKey key: StorageManager.Keys)
    func bool(forKey key: StorageManager.Keys) -> Bool?
}

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    public enum Keys: String {
        case isDark
    }

    private let userDefaults = UserDefaults.standard

    private func store(_ object: Any?, key: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.userDefaults.set(object, forKey: key)
        }
    }

    private func restore(forKey key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
    
    func set(_ object: Any?, forKey key: Keys) {
        store(object, key: key.rawValue)
    }
    
    func bool(forKey key: Keys) -> Bool? {
        restore(forKey: key.rawValue) as? Bool
    }

    func remove(forKey key: Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
