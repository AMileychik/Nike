// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AppComposition",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AppComposition",
            targets: ["AppComposition"]),
    ],
    dependencies: [
        .package(path: "../AppInterface"),
        .package(path: "../Services")
    ],
    targets: [
        .target(
            name: "AppComposition",
        dependencies: [
            .product(name: "AppInterface", package: "AppInterface"),
            .product(name: "Services", package: "Services")
        ]
        ),
        .testTarget(
            name: "AppCompositionTests",
            dependencies: ["AppComposition"]),
    ]
)
