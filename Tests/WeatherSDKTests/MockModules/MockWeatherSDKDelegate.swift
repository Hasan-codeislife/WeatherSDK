@testable import WeatherSDK

class MockWeatherSDKDelegate: WeatherSDKDelegate {
    var onFinishedCalled = false
    var onFinishedWithErrorCalled = false
    var didDismissSuccessfullyCalled = false
    var receivedError: WeatherError?

    func onFinished() {
        onFinishedCalled = true
    }

    func onFinishedWithError(_ error: WeatherError) {
        onFinishedWithErrorCalled = true
        receivedError = error
    }

    func didDismissSuccessfully() {
        didDismissSuccessfullyCalled = true
    }
}
