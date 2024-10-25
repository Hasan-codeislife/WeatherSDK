import SwiftUI

struct WeatherListItemView: View {
    
    let dayWeather: WeatherModel?
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                CustomTextView(text: "\(dayWeather?.local24Time ?? "")")
                CustomTextView(text: "\(String(format: "%.1f", dayWeather?.temperature ?? 0.0))°C", style: .bodyBold)
                CustomTextView(text: "\(dayWeather?.weather.description ?? "")")
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.visible, edges: .all)
        .listRowSeparatorTint(.gray)
        .padding()
    }
}
