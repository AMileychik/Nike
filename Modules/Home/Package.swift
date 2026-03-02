// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(path: "../AppDomain"),
        .package(path: "../DesignSystem"),
        .package(path: "../AppInterface"),
        .package(path: "../AppComposition"),
        .package(path: "../Detail"),
        .package(path: "../Bag"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                .product(name: "AppDomain", package: "AppDomain"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "AppInterface", package: "AppInterface"),
                .product(name: "AppComposition", package: "AppComposition"),
                .product(name: "Detail", package: "Detail"),
                .product(name: "Bag", package: "Bag"),
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
    ]
)
