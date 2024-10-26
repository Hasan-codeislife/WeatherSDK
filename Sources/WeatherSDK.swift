import Combine
import Foundation
import ComposableArchitecture
import SwiftUI

/// A delegate protocol that provides methods for handling events from the Weather SDK.
///
/// Conform to the `WeatherSDKDelegate` protocol to receive callbacks for various actions,
/// such as successfully completing an operation, handling an error, or dismissing the SDK.
///
/// Implement this protocol in your class to respond to SDK events.
public protocol WeatherSDKDelegate: AnyObject {
    
    /// Called when a process within the Weather SDK has completed successfully.
    ///
    /// Implement this method to perform actions upon a successful operation,
    /// such as updating the UI or notifying the user.
    func onFinished()
    
    /// Called when a process within the Weather SDK has completed with an error.
    ///
    /// - Parameter error: The `WeatherError` object describing the error encountered.
    ///
    /// Implement this method to handle errors from the SDK, such as displaying
    /// an alert to the user or logging the error for debugging.
    func onFinishedWithError(_ error: WeatherError)
    
    /// Called when the SDK has been dismissed successfully.
    ///
    /// Implement this method to handle any cleanup or navigation that should occur
    /// after the SDK is dismissed.
    func didDismissSuccessfully()
}

/// The main and only class that provides access to the Weather SDK functionality.
///
/// The `WeatherSDK` class is the main entry point for integrating the Weather SDK
/// into your application. It requires an API key for initialization to access weather data.
public class WeatherSDK {
    
    /// Initializes a new instance of the `WeatherSDK` with the specified API key.
    ///
    /// - Parameter apiKey: A string representing the API key required for authenticating
    ///                     requests to the weather service. This key is used to ensure
    ///                     that the SDK can access the necessary weather data on behalf
    ///                     of your application.
    ///
    /// Usage:
    /// ```swift
    /// let weatherSDK = WeatherSDK(apiKey: "your_api_key_here")
    /// ```
    ///
    /// - Note: Ensure that the API key is valid and retrieved after signing up on [weatherbit](https://www.weatherbit.io).
    public init(apiKey: String) {
        WeatherSDKConfiguration.apiKey = apiKey
    }
    
    /// Fetches weather data for a specified city and returns a view to display the weather information.
    ///
    /// This method is designed to be called on the main actor, ensuring that all UI updates
    /// and interactions are performed on the main thread. It initializes a `Store` with the
    /// provided city name and creates a `WeatherView` that will present the weather data
    /// to the user.
    ///
    /// - Parameters:
    ///   - city: The name of the city for which to fetch weather data. This string is used
    ///           to query the weather service and retrieve the current weather conditions.
    ///   - delegate: An object conforming to the `WeatherSDKDelegate` protocol, which receives
    ///               callbacks regarding the state of the weather fetching operation, such as
    ///               success or failure notifications.
    ///
    /// - Returns: A view representing the weather information for the specified city.
    ///            The returned view is wrapped in an `AnyView` for type erasure, allowing it
    ///            to be used flexibly within SwiftUI views.
    ///
    /// - Note: Ensure that the `WeatherSDK` instance is initialized with a valid API key
    ///         before calling this method. The method is asynchronous and should be awaited
    ///         to handle the potential delay in fetching data from the weather service.
    ///
    /// Usage:
    /// ```swift
    /// let weatherView = weatherSDK.fetchWeather(forCity: "Berlin", delegate: self)
    /// ```
    @MainActor
    public func fetchWeather(forCity city: String, delegate: WeatherSDKDelegate) -> some View {
        let store = Store(initialState: WeatherViewReducer.State(cityName: city), reducer: {
            WeatherViewReducer(delegate: delegate)
        })
        let view = WeatherView(store: store)
        return AnyView(view)
    }
}

/// An enumeration representing the various errors that can occur within the Weather SDK.
///
/// This enum conforms to the `Error` protocol, allowing it to be used for error handling
/// in weather-related operations. Each case describes a specific type of error that may
/// arise during the fetching or processing of weather data.
public enum WeatherError: Error {
    /// An error indicating that the provided URL is invalid.
    ///
    /// This case is used when the URL used to make a network request is malformed or
    /// cannot be constructed properly.
    case invalidURL
    /// An error indicating a network-related issue.
    ///
    /// - Parameter error: The underlying `Error` that describes the network issue encountered,
    ///                    such as connectivity problems or timeouts.
    case networkError(Error)
    /// An error indicating that the response received from the weather service was invalid.
    ///
    /// This case is used when the response format does not match the expected structure
    /// or contains unexpected status codes.
    case invalidResponse
    /// An error indicating that there was an issue decoding the response data.
    ///
    /// This case is triggered when the data received cannot be converted to the expected
    /// model type, often due to mismatched data formats or corrupted data.
    case decodingError
}
