import Foundation
import Testing
@testable import WeatherSDK

class SDKConfigurationTests {

    @Test func testSDKConfiguration() async {
        let apiKey = UUID().uuidString
        WeatherSDKConfiguration.apiKey = apiKey
        #expect(WeatherSDKConfiguration.apiKey == apiKey, "API KEY setting and retrieval is not working as expected")
    }
}
