import Combine
import Foundation
import ComposableArchitecture
import SwiftUI

public protocol WeatherSDKDelegate: AnyObject {
    func onFinished()
    func onFinishedWithError(_ error: WeatherError)
    func didDismissSuccessfully()
}

public class WeatherSDK {
    
    public init(apiKey: String) {
        AppConstants.NetworkAPIKey = apiKey
    }

    @MainActor
    public func fetchWeather(forCity city: String, delegate: WeatherSDKDelegate) async -> some View {
        let store = await Store(initialState: WeatherViewReducer.State(cityName: city), reducer: {
            WeatherViewReducer(delegate: delegate)
        })
        let view = WeatherView(store: store)
        return AnyView(view)
    }
}

public enum WeatherError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError
}
