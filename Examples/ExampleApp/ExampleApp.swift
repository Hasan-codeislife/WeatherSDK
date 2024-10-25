import ComposableArchitecture
import SwiftUI
import WeatherSDK

@main
struct WeatherAppProjectApp: App {
    
    private static let store = Store(initialState: ExampleViewReducer.State(), reducer: {
        ExampleViewReducer()
    })

    var body: some Scene {
        
        WindowGroup {
            ExampleView(store: WeatherAppProjectApp.store)
        }
    }
}
