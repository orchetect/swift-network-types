// swift-tools-version: 6.0

import Foundation
import PackageDescription

let package = Package(
    name: "swift-network-types",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)],
    products: [
        .library(
            name: "SwiftNetworkTypes",
            targets: ["SwiftNetworkTypes"]
        )
    ],
    dependencies: [
        // Testing-only dependencies
        // .package(url: "https://github.com/orchetect/swift-testing-extensions", from: "0.3.1")
    ],
    targets: [
        .target(
            name: "SwiftNetworkTypes",
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        ),
        .testTarget(
            name: "SwiftNetworkTypesTests",
            dependencies: [
                "SwiftNetworkTypes"
                // .product(name: "TestingExtensions", package: "swift-testing-extensions")
            ]
        )
    ]
)

// MARK: - Utilities

func hasEnvironmentVariable(_ name: String) -> Bool {
    ProcessInfo.processInfo.environment[name] != nil
}

// MARK: - CI Pipeline

if hasEnvironmentVariable("GITHUB_ACTIONS") {
    for target in package.targets.filter(\.isTest) {
        if target.swiftSettings == nil { target.swiftSettings = [] }
        target.swiftSettings? += [.define("GITHUB_ACTIONS", .when(configuration: .debug))]
    }
}
