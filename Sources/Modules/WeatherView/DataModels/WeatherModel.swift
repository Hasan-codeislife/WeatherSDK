import Foundation

struct WeatherModel: Equatable, Identifiable {
    let id: UUID = UUID()
    var temperature: Double
    var local24Time: String
    var weather: WeatherDescriptionModel
    
    init(temperature: Double, local24Time: String, weather: WeatherDescriptionModel) {
        self.temperature = temperature
        self.local24Time = local24Time
        self.weather = weather
    }
    
    init?(item: WeatherInfoNetworkModel) {
        guard let temperature = item.temperature,
              let timestamp = item.timestamp,
              let description = item.weather?.description else { return nil }
        
        let local24Time = DateFormatter().convertUTCToLocalTime(utcTimestamp: timestamp)
        let weatherDescription = WeatherDescriptionModel(description: description)
        self.init(temperature: temperature, local24Time: local24Time, weather: weatherDescription)
    }
    
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct WeatherDescriptionModel: Codable {
    var description: String
    
    init(description: String) {
        self.description = description
    }
}
