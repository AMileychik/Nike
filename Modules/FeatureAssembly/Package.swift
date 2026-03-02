// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeatureAssembly",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "FeatureAssembly",
            targets: ["FeatureAssembly"]),
    ],
    dependencies: [
        .package(path: "../AppComposition"),
        .package(path: "../Bag"),
        .package(path: "../Home"),
        .package(path: "../AppInterface"),
        .package(path: "../Detail")
    ],
    targets: [
        .target(
            name: "FeatureAssembly",
            dependencies: [
                .product(name: "AppComposition", package: "AppComposition"),
                .product(name: "Bag", package: "Bag"),
                .product(name: "Home", package: "Home"),
                .product(name: "AppInterface", package: "AppInterface"),
                .product(name: "Detail", package: "Detail")
            ]
        ),
        .testTarget(
            name: "FeatureAssemblyTests",
            dependencies: ["FeatureAssembly"]),
    ]
)

