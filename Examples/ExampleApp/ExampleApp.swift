import ComposableArchitecture
import SwiftUI
import WeatherSDK

@main
struct ExampleApp: App {
    
    private static let store = Store(initialState: ExampleViewReducer.State(), reducer: {
        ExampleViewReducer()
    })

    var body: some Scene {
        
        WindowGroup {
            ExampleView(store: ExampleApp.store)
        }
    }
}
