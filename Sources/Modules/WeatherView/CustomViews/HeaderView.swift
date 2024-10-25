import SwiftUI

struct HeaderView: View {
    
    let cityName: String?
    let currentWeather: WeatherModel?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            
            CustomTextView(text: String(format: "ui.headerView.title".localized, cityName ?? ""),
                           style: .body,
                           alignment: .center)
            
            let temperature = currentWeather?.temperature ?? 0.0
            CustomTextView(text: String(format: "ui.headerView.temperature".localized, temperature),
                           style: .title,
                           alignment: .center)
            
            CustomTextView(text: "\(currentWeather?.weather.description ?? "")",
                           style: .body,
                           alignment: .center)
            
            let localTime = currentWeather?.local24Time ?? ""
            CustomTextView(text: String(format: "ui.headerView.time".localized, localTime),
                           style: .light,
                           alignment: .center)
        }.padding()
    }
}
