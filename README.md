# Weather SDK

The **Weather SDK** provides an easy-to-use interface for accessing weather data from the [WeatherBit API](https://www.weatherbit.io/). With this SDK, developers can quickly fetch current weather conditions and hourly forecasts based on the city name.

# Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Installation](#installation)
   - [Swift Package Manager](#swift-package-manager)
4. [Importing the SDK](#importing-the-sdk)
5. [Initializing the SDK](#initializing-the-sdk)
6. [Usage](#usage)
   - [`fetchWeather(forCity:delegate:)`](#fetchweatherforcitydelegate)
   - [`WeatherSDKDelegate`](#weathersdkdelegate)
     - [Methods](#methods)
       - [`onFinished()`](#onfinished)
       - [`onFinishedWithError(_:)`](#onfinishedwitherror_)
       - [`didDismissSuccessfully()`](#diddismisssuccessfully)
7. [Using the Weather SDK with UIKit](#using-the-weather-sdk-with-uikit)
   - [Step 1: Initialize the SDK](#step-1-initialize-the-sdk)
   - [Step 2: UIHostingController](#step-2-uihostingcontroller)
## Features

- Fetch current weather data
- Retrieve hourly forecasts for the next 24 hours
- Built with Swift and designed for seamless integration into SwiftUI applications

## Installation

To integrate the Weather SDK into your Swift project, follow these steps:

### Swift Package Manager

1. Open your Xcode project.
2. Navigate to **File** > **Swift Packages** > **Add Package Dependency**.
3. Enter the following URL: https://github.com/yourusername/WeatherSDK.git
4. Choose the version you want to install.

### Importing the SDK

In your Swift files, import the Weather SDK:

```swift
import WeatherSDK
```

### Initializing the SDK
Before you start using the SDK in your application, you need to initialize it. This should be done early in your app's lifecycle, ideally in the `AppDelegate` or the main entry point of your SwiftUI app. You need a `YOUR_API_KEY` to initialise it. You can get it [here](https://www.weatherbit.io) after registering.

```swift
import WeatherSDK
// Initialize the WeatherSDK with your API key
let weatherSDK = WeatherSDK(apiKey: "YOUR_API_KEY")
````
### Usage

#### `fetchWeather(forCity:delegate:)`

Fetches the current weather for a specified city and returns a SwiftUI view that displays the weather information.

- **Parameters**:
  - `forCity`: A `String` representing the name of the city for which to fetch the weather.
  - `delegate`: An instance conforming to the `WeatherSDKDelegate` protocol that will receive updates about the weather data fetching process.

- **Returns**: 
  - A view conforming to `some View` that contains the weather information, including current conditions and forecasts.

#### `WeatherSDKDelegate`

The `WeatherSDKDelegate` protocol provides a mechanism for receiving updates about the weather data fetching process. By conforming to this protocol, you can handle both successful weather data retrieval and any errors that may occur during the fetching process.

### Methods

#### `onFinished()`

Called when the weather data is successfully fetched. This method provides the fetched weather data for further processing or display.

##### Example Implementation:

```swift
class WeatherDelegate: WeatherSDKDelegate {
    func onFinished() {
        print("Weather view was returned successfully")
    }
}
````

#### `onFinishedWithError(_:)`

Called when there is an error during the weather data fetching process. This method allows you to handle errors gracefully, providing feedback to users or triggering fallback behavior.

- **Parameters**:
  - `error`: An instance of `WeatherError` that describes the specific error that occurred during the fetching process. The `WeatherError` type encapsulates different error scenarios, such as network failures or invalid responses.

##### Example Implementation:

```swift
class WeatherDelegate: WeatherSDKDelegate {
    func onFinishedWithError(_ error: WeatherError) {
            print("An error occurred: \(error.localizedDescription)")
        }
    }
}
```
#### `didDismissSuccessfully()`

Called when the weather view is dismissed successfully. This method allows you to perform any necessary cleanup or state updates in your application after the weather view has been closed.

##### Example Implementation:

```swift
class WeatherDelegate: WeatherSDKDelegate {
    func didDismissSuccessfully() {
        // Handle the successful dismissal of the weather view
        print("The weather view was dismissed successfully.")
        // Perform any additional cleanup or state updates here
    }
}
```
## Using the Weather SDK with UIKit

If you are building an application using UIKit instead of SwiftUI, you can still integrate the Weather SDK seamlessly. Here are the steps to get started:

### Step 1: Initialize the SDK

As with SwiftUI, you will first need to initialize the SDK in your `AppDelegate` or the main view controller:

```swift
import WeatherSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let weatherSDK = WeatherSDK(apiKey: "YOUR_API_KEY")
    // Other app delegate methods...
}
```
### Step 2: UIHostingController
Wrap your SwiftUI view in `UIHostingController`. This allows you to present and manage a SwiftUI view from a UIKit context. Below is how you can do it in a function in your `viewController`:
```swift
private func setupSwiftUIView() {
        // Create the SwiftUI view
        let weatherSDKView = await self.fetchWeather(forCity: cityName, delegate: self)

        // Create a UIHostingController with the SwiftUI view
        let hostingController = UIHostingController(rootView: weatherView)
        
        // Add the hosting controller as a child
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // Set the frame for the hosting controller's view
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify the hosting controller that it has been moved to a parent
        hostingController.didMove(toParent: self)
    }
}
```
