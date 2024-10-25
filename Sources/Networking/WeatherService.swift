import Foundation

protocol WeatherServiceProtocol {
    func getForecast(cityName: String) async throws -> (WeatherModel, [WeatherModel])
}


final class WeatherService: WeatherServiceProtocol {
    
    private let apiManager: ApiManagerProtocol
    init(apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func getForecast(cityName: String) async throws -> (WeatherModel, [WeatherModel]) {
        let currentEndPoint = WeatherEndPoint.getCurrentForecase(cityName: cityName)
        let dayEndPoint = WeatherEndPoint.getDayForecast(cityName: cityName)
        do {
            let currentResponse: WeatherNetworkResponse = try await apiManager.makeNetworkCall(router: currentEndPoint)
            let dayResponse: WeatherNetworkResponse = try await apiManager.makeNetworkCall(router: dayEndPoint)
            
            guard let current = currentResponse.data?.first,
                  let currentModel = WeatherModel.init(item: current),
                  let day = dayResponse.data else {
                throw MyError.apiResponseError
            }
            var dayModel = [WeatherModel]()
            try day.forEach { item in
                guard let timestamp = item.timestamp,
                      let model = WeatherModel.init(item: item)
                else {
                    throw MyError.apiResponseError
                }
                timestamp > Date().timeIntervalSinceNow ? dayModel.append(model) : ()
            }
            return (currentModel, dayModel)
        } catch let error {
            throw error
        }
    }
}

// Using Factory to initialize the Service
extension WeatherService {
    static func create() -> WeatherService {
        return WeatherService(apiManager: ApiManager(client: APIClientURLSession()))
    }
    
    static func createMockService() -> WeatherService {
        return WeatherService(apiManager: ApiManager(client: MockAPIClient()))
    }
}
