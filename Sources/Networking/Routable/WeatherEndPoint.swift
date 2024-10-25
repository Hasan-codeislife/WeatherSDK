import Foundation

enum WeatherEndPoint: Routable {
    
    private var apiKey: String {
        WeatherSDKConfiguration.apiKey
    }
    
    case getCurrentForecase(cityName: String)
    case getDayForecast(cityName: String)
    
    var path: String {
        switch self {
        case .getCurrentForecase(let cityName):
            return baseURLString + "/current?city=\(cityName)&key=\(apiKey)"
        case .getDayForecast(let cityName):
            return baseURLString + "/forecast/hourly?city=\(cityName)&hours=\(24)&key=\(apiKey)"
        }
    }
    
    var params: APIParams? {
        return nil
    }
    
    var method: APIMehtod {
        switch self {
        case .getCurrentForecase, .getDayForecast:
            return .get
        }
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: self.path)!
        return URLRequest(requestURL: url,
                          method: self.method,
                          header: nil,
                          body: self.params ?? nil)
    }
}
