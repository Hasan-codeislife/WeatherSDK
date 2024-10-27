import Foundation
import Testing
@testable import WeatherSDK

class NetworkLayerTests {
    
    // Helper method to create a valid URL from a string
    private func createURL(from string: String) throws -> URL {
        guard let url = URL(string: string) else {
            throw URLError(.badURL)
        }
        return url
    }
    
    @Test func testJSONFileRetrieval() async {
        let testURLString = "https://api.weatherbit.io/v2.0/forecast/hourly?city=\(MockData.mockCity)&hours=24&key=random-api-key"
        let testURL = try! createURL(from: testURLString)
        let urlRequest = URLRequest(url: testURL)
        let mockAPIClient = MockAPIClient()
        let jsonFileName = mockAPIClient.getFileName(from: urlRequest)
        
        #expect(jsonFileName == "get_hourly", "Expected to retrieve 'get_hourly' as the JSON file name")

    }
    
    @Test func testJSONParsing() async {
        let mockAPIClient = MockAPIClient()
        let service = WeatherService(apiManager: ApiManager(client: mockAPIClient))
        
        do {
            let (current, day) = try await service.getForecast(cityName: MockData.mockCity)
            #expect(current != nil, "Expected to parse and retrieve valid current weather from JSON")
            #expect(day != nil, "Expected to parse and retrieve valid hourly weather from JSON")
        } catch {
            #expect(Bool(false), "JSON parsing failed with error: \(error)")
        }
    }
}
