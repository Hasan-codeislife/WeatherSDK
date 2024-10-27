@testable import WeatherSDK

enum MockData {
    static let mockCity = "Berlin"
    static let mockCurrentWeather = WeatherModel(temperature: 23.5, local24Time: "11:50", weather: WeatherDescriptionModel(description: "Sunny"))
    static let mockDayWeather = [WeatherModel(temperature: 23.5, local24Time: "18:00", weather: WeatherDescriptionModel(description: "Cloudy"))]
}
