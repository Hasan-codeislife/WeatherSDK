import Foundation

struct WeatherNetworkResponse: Codable {
    
    var data: [WeatherInfoNetworkModel]?
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            data = try values.decodeIfPresent([WeatherInfoNetworkModel].self, forKey: .data)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct WeatherInfoNetworkModel: Codable {
    var temperature: Double?
    var timestamp: TimeInterval?
    var weather: WeatherDescriptionNetworkModel?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case timestamp = "ts"
        case weather
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
            timestamp = try values.decodeIfPresent(TimeInterval.self, forKey: .timestamp)
            weather = try values.decodeIfPresent(WeatherDescriptionNetworkModel.self, forKey: .weather)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct WeatherDescriptionNetworkModel: Codable {
    var description: String?
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            description = try values.decodeIfPresent(String.self, forKey: .description)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
