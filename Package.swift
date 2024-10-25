// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WeatherSDK",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "WeatherSDK",
            targets: ["WeatherSDK"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.15.2")
    ],
    targets: [
        .target(
            name: "WeatherSDK",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ],
            path: "Sources",
            exclude: ["../Tests", "../Examples"],
            resources: [
                .process("Networking/MockJSON/get_current.json"),
                .process("Networking/MockJSON/get_hourly.json"),
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "WeatherSDKTests",
            dependencies: ["WeatherSDK"],
            path: "Tests"
        )
    ]
)
