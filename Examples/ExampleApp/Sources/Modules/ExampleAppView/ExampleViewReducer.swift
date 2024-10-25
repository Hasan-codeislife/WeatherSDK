import ComposableArchitecture
import SwiftUI
import WeatherSDK

class ExampleViewReducer: Reducer {
    
    struct State: Equatable {
        
        var id = UUID()
        var cityName: String = ""
        var isLoading: Bool = false
        var errorMessage: String? = nil
        var shouldlaunchSDK: Bool = false
        var weatherSDKView: AnyView? = nil
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.id == rhs.id &&
            lhs.isLoading == rhs.isLoading &&
            lhs.shouldlaunchSDK == rhs.shouldlaunchSDK &&
            lhs.cityName == rhs.cityName
        }
    }
    
    enum Action {
        case cityChanged(String)
        case fetchWeather
        case featchWeatherFailed(Error)
        case launchSDK(any View)
        case dismissSDK
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .cityChanged(let cityName):
            state.cityName = cityName
            return .none
        case .fetchWeather:
            state.isLoading = true
            let cityName = state.cityName
            return .run { send in
                let weatherSDKView = await self.fetchWeather(forCity: cityName, delegate: self)
                await send(.launchSDK(weatherSDKView))
            }
        case .featchWeatherFailed(let error):
            state.errorMessage = error.localizedDescription
            return .none
        case .launchSDK(let weatherSDKView):
            state.isLoading = false
            state.shouldlaunchSDK = true
            state.weatherSDKView = AnyView(weatherSDKView)
            return .none
        case .dismissSDK:
            state.weatherSDKView = nil
            state.shouldlaunchSDK = false
            return .none
        }
        
    }
    
    @MainActor
    func fetchWeather(forCity city: String, delegate: WeatherSDKDelegate) -> some View {
        let weatherSDK = WeatherSDK(apiKey: "6786a7dfe82e4e4889bef3b044ebe13b")
        let view = weatherSDK.fetchWeather(forCity: city, delegate: delegate)
        return view
    }
}

// Delegate functions to handle things on the main app
extension ExampleViewReducer: WeatherSDKDelegate {
    func onFinished() {
        print("didFetchWeatherData delegate function called")
    }
    
    func onFinishedWithError(_ error: WeatherError) {
        print("didFailWithError delegate function called")
    }
    
    func didDismissSuccessfully() {
        print("didDismissSuccessfully delegate function called")
    }
}
