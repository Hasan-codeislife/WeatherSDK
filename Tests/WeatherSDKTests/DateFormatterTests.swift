import Foundation
import Testing
@testable import WeatherSDK

class DateFormatterTests {

    @Test func testDateFormat() async {
        let timestamp = TimeInterval(1729980960601)
        let convertedTime = DateFormatter().convertUTCToLocalTime(utcTimestamp: timestamp)
        #expect(convertedTime == "19:50", "Date formatting or value conversion failed")
    }
}
