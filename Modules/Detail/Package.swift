// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Detail",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Detail",
            targets: ["Detail"]),
    ],
    dependencies: [
        .package(path: "../AppInterface"),
        .package(path: "../DesignSystem"),
        .package(path: "../AppCore"),
        .package(path: "../AppDomain"),
        .package(path: "../SharedUI")
    ],
    targets: [
        .target(
            name: "Detail",
            dependencies: [
                .product(name: "AppInterface", package: "AppInterface"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "AppCore", package: "AppCore"),
                .product(name: "AppDomain", package: "AppDomain"),
                .product(name: "SharedUI", package: "SharedUI")
            ]
        ),
        .testTarget(
            name: "DetailTests",
            dependencies: ["Detail"]),
    ]
)

