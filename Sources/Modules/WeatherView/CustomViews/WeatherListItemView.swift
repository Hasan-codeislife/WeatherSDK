import SwiftUI

struct WeatherListItemView: View {
    
    let dayWeather: WeatherModel?
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                CustomTextView(text: "\(dayWeather?.local24Time ?? "")")
                
                let temperature = dayWeather?.temperature ?? 0.0
                CustomTextView(text: String(format: "ui.weatherListItemView.temperature".localized, temperature), style: .bodyBold)
                CustomTextView(text: "\(dayWeather?.weather.description ?? "")")
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.visible, edges: .all)
        .listRowSeparatorTint(.gray)
        .padding()
    }
}
