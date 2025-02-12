import ComposableArchitecture
import SwiftUI

struct WeatherView: View {
    
    @Bindable var store: StoreOf<WeatherViewReducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                if viewStore.isLoading {
                    ProgressView()
                        .padding(.top, 20)
                }
                if viewStore.currentWeather == nil || viewStore.dayWeather == nil {
                    if !viewStore.isLoading {
                        CustomTextView(text: "ui.genericError".localized, style: .title)
                    }
                } else {
                    VStack(alignment: .center) {
                        HeaderView(cityName: viewStore.cityName, currentWeather: viewStore.currentWeather)
                        List(viewStore.dayWeather ?? []) { weather in
                            WeatherListItemView(dayWeather: weather)
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationBarTitle("ui.weatherView.navigationTitle".localized, displayMode: .automatic)
            .toolbarBackground(Color.gray.opacity(0.2), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear() {
                viewStore.send(.fetchWeather)
            }
            .onDisappear() {
                viewStore.send(.dismissSDK)
            }
        }
    }
}
