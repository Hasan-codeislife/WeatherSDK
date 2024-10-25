import Foundation

extension DateFormatter {
    func convertUTCToLocalTime(utcTimestamp: TimeInterval) -> String {
        let utcDate = Date(timeIntervalSince1970: utcTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        let localTimeString = dateFormatter.string(from: utcDate)
        return localTimeString
    }
}

