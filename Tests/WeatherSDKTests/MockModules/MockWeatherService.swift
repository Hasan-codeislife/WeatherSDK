import Foundation
@testable import WeatherSDK

final class MockWeatherService: WeatherServiceProtocol, @unchecked Sendable {
    var shouldSucceed = true
    var mockCurrentWeather = MockData.mockCurrentWeather
    var mockDayWeather = MockData.mockDayWeather
    func getForecast(cityName: String) async throws -> (WeatherModel, [WeatherModel]) {
        if shouldSucceed {
            return (mockCurrentWeather, mockDayWeather)
        } else {
            throw WeatherError.networkError(NSError(domain: "", code: -1, userInfo: nil))
        }
    }
}
