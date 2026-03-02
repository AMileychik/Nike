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
        .package(path: "../AppInterface")
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                .product(name: "AppInterface", package: "AppInterface")
            ]
        ),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]
        ),
    ]
)
