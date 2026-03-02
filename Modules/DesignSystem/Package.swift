// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "DesignSystem", 
                 targets: ["DesignSystem"]),
    ],
    dependencies: [
        .package(path: "../AppCore"),
        .package(path: "../AppInterface")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "AppCore", package: "AppCore"),
                .product(name: "AppInterface", package: "AppInterface")
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"]
        )
    ]
)
