// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "RootUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "RootUI",
            targets: ["RootUI"]),
    ],
    dependencies: [
        .package(path: "../AppInterface"),
        .package(path: "../AppCore"),
        .package(path: "../Bag"),
        .package(path: "../Home"),
        .package(path: "../FeatureAssembly")
    ],
    targets: [
        .target(
            name: "RootUI",
            dependencies: [
                .product(name: "AppInterface", package: "AppInterface"),
                .product(name: "AppCore", package: "AppCore"),
                .product(name: "Bag", package: "Bag"),
                .product(name: "Home", package: "Home"),
                .product(name: "FeatureAssembly", package: "FeatureAssembly")
            ]
        ),
        .testTarget(
            name: "RootUITests",
            dependencies: ["RootUI"]),
    ]
)
