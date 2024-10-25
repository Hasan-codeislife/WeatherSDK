import Foundation

enum WeatherEndPoint: Routable {
    
    private var apiKey: String {
        return AppConstants.NetworkAPIKey
    }
    
    case getCurrentForecase(cityName: String)
    case getDayForecast(cityName: String)
    
    var path: String {
        switch self {
        case .getCurrentForecase(let cityName):
            return baseURLString + "/current?city=\(cityName) &key=\(apiKey)"
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

//https://api.weatherbit.io/v2.0/current\?city=Munich&key=6786a7dfe82e4e4889bef3b044ebe13b
//https://api.weatherbit.io/v2.0/forecast/hourly?city=Munich&hours=24&key=6786a7dfe82e4e4889bef3b044ebe13b
