import Foundation

class WeatherSDKConfiguration {
    private static let apiKeyKey = "WeatherSDK-APIKey"
    static var apiKey: String {
        get {
            // Retrieve the API key from User Defaults
            return UserDefaults.standard.string(forKey: apiKeyKey) ?? ""
        }
        set {
            guard !newValue.isEmpty else {
                fatalError("API key cannot be empty")
            }
            UserDefaults.standard.set(newValue, forKey: apiKeyKey)
            UserDefaults.standard.synchronize()
        }
    }
}
