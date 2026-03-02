// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AppCore",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AppCore",
            targets: ["AppCore"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppCore",
            path: "Sources/AppCore",
            resources: [],
            swiftSettings: [
                .define("SWIFT_PACKAGE")
            ]
        ),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]
        ),
    ]
)
