import SwiftUI

struct HeaderView: View {
    
    let cityName: String?
    let currentWeather: WeatherModel?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            CustomTextView(text: "The weather in \(cityName ?? "") is:", style: .body, alignment: .center)
            CustomTextView(text: "\(String(format: "%.1f", currentWeather?.temperature ?? 0.0))°C", style: .title, alignment: .center)
            CustomTextView(text: "\(currentWeather?.weather.description ?? "")", style: .body, alignment: .center)
            CustomTextView(text: "AT: \(currentWeather?.local24Time ?? "") LOCAL TIME", style: .light, alignment: .center)
        }.padding()
    }
}
