// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SharedUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0"),
        .package(path: "../AppCore"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "SharedUI",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "AppCore", package: "AppCore"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "SharedUITests",
            dependencies: ["SharedUI"])
    ]
)
