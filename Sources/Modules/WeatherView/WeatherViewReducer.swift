import ComposableArchitecture
import Foundation

class WeatherViewReducer: Reducer {
    
    struct State: Equatable {
        
        var id = UUID()
        var cityName: String = ""
        var currentWeather: WeatherModel? = nil
        var dayWeather: [WeatherModel]? = nil
        var isLoading: Bool = false
        var errorMessage: String?
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.id == rhs.id &&
            lhs.cityName == rhs.cityName &&
            lhs.currentWeather == rhs.currentWeather &&
            lhs.dayWeather == rhs.dayWeather &&
            lhs.isLoading == rhs.isLoading &&
            lhs.errorMessage == rhs.errorMessage
        }
    }
    
    enum Action {
        case fetchWeather
        case weatherResponse(Result<(WeatherModel, [WeatherModel]), WeatherError>)
        case dismissSDK
    }
    
    init(delegate: WeatherSDKDelegate, service: WeatherServiceProtocol = WeatherService.create()) {
        self.delegate = delegate
        self.service = service
    }
    
    weak var delegate: WeatherSDKDelegate?
    var service: WeatherServiceProtocol
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchWeather:
            let cityName = state.cityName
            state.isLoading = true
            let service = self.service
            return .run { send in
                do {
                    let (current, day) = try await service.getForecast(cityName: cityName)
                    await send(.weatherResponse(.success((current, day))))
                } catch let error {
                    await send(.weatherResponse(.failure(.networkError(error))))
                }
            }
        case .weatherResponse(let result):
            state.isLoading = false
            switch result {
            case .success(let (currentWeather, dayWeather)):
                state.currentWeather = currentWeather
                state.dayWeather = dayWeather
                self.delegate?.onFinished()
            case .failure(let error):
                // extend functionality:- It can be handled with a separate view
                state.errorMessage = error.localizedDescription
                self.delegate?.onFinishedWithError(error)
            }
            return .none
        case .dismissSDK:
            self.delegate?.didDismissSuccessfully()
            return .none
        }
    }
}
