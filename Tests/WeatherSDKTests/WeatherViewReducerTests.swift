import Foundation
import Testing
import ComposableArchitecture
@testable import WeatherSDK

final class WeatherViewReducerTests {
    
    var delegate: MockWeatherSDKDelegate!
    var service: MockWeatherService!
    
    init() {
        delegate = MockWeatherSDKDelegate()
        service = MockWeatherService()
    }
    
    @Test func testFetchWeatherSuccess() async {
        
        let reducer = WeatherViewReducer(delegate: delegate, service: service)
        var state = WeatherViewReducer.State(cityName: MockData.mockCity)
        service.shouldSucceed = true
        
        _ = reducer.reduce(into: &state, action: .fetchWeather)
        #expect(state.isLoading, "State should be loading after fetchWeather action")
        
        _ = reducer.reduce(into: &state, action: .weatherResponse(.success((MockData.mockCurrentWeather, MockData.mockDayWeather))))
        
        #expect(!state.isLoading, "State should not be loading after weatherResponse action")
        #expect(state.currentWeather?.id == service.mockCurrentWeather.id, "Current weather should match the mock data")
        #expect(state.dayWeather?.first?.id == service.mockDayWeather.first?.id, "Day weather should match the mock data")
        #expect(delegate.onFinishedCalled, "Delegate's onFinished should be called on success")
    }
    
    @Test func testFetchWeatherFailure() async {
        
        let reducer = WeatherViewReducer(delegate: delegate, service: service)
        var state = WeatherViewReducer.State(cityName: MockData.mockCity)
        service.shouldSucceed = false
        
        _ = reducer.reduce(into: &state, action: .fetchWeather)
        #expect(state.isLoading, "State should be loading after fetchWeather action")
        
        _ = reducer.reduce(into: &state, action: .weatherResponse(.failure(WeatherError.invalidResponse)))
        
        #expect(state.errorMessage != nil, "State should contain error message on failure")
        #expect(delegate.onFinishedWithErrorCalled, "Delegate's onFinishedWithError should be called on failure")
    }
    
    @Test func testDismissSDKAction() {
        
        let reducer = WeatherViewReducer(delegate: delegate, service: service)
        var state = WeatherViewReducer.State(cityName: MockData.mockCity)
        _ = reducer.reduce(into: &state, action: .dismissSDK)
        
        #expect(state.errorMessage == nil, "State should not have an error message on dismiss action")
        #expect(delegate.didDismissSuccessfullyCalled, "Delegate's didDismissSuccessfully should be called on dismiss action")
    }
}
