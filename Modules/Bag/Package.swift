// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bag",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Bag",
                 targets: ["Bag"]),
    ],
    dependencies: [
        .package(path: "../AppInterface"),
        .package(path: "../DesignSystem"),
        .package(path: "../Services"),
        .package(path: "../SharedUI")
    ],
    targets: [
        .target(
            name: "Bag",
            dependencies: [
                .product(name: "AppInterface", package: "AppInterface"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Services", package: "Services"),
                .product(name: "SharedUI", package: "SharedUI")
            ]
        ),
        .testTarget(
            name: "BagTests",
            dependencies: ["Bag"]),
    ]
)
