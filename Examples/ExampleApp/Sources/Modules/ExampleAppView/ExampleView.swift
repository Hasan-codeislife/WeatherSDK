import ComposableArchitecture
import SwiftUI

struct ExampleView: View {

    @Bindable var store: StoreOf<ExampleViewReducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    Text("Enter a city name for the weather forecast")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .padding()
                        .padding(.top, 14)
                    
                    CustomTextFieldView(placeholder: "Search City", text: viewStore.binding(
                        get: \.cityName,
                        send: ExampleViewReducer.Action.cityChanged
                    ))
                    
                    CustomButton(action: {
                        viewStore.send(.fetchWeather)
                    })
                    .disabled(viewStore.cityName.isEmpty || viewStore.isLoading)

                    if viewStore.isLoading {
                        ProgressView()
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                }
                .navigationDestination(isPresented: viewStore.binding(
                    get: \.shouldlaunchSDK,
                    send: ExampleViewReducer.Action.dismissSDK
                )) {
                    if let view = viewStore.weatherSDKView {
                        view
                    }
                }
                .navigationTitle("Example App")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
    
}
