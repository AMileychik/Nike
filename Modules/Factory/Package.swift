// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Factory",
    platforms: [
        .iOS(.v15)],
    products: [
        .library(name: "Factory", targets: ["Factory"]),
    ],
    dependencies: [
        .package(path: "../Shop"),
        .package(path: "../AppInterface")
    ],
    targets: [
        .target(
            name: "Factory",
            dependencies: [
                .product(name: "ShopPresenter", package: "Shop"),
                .product(name: "AppInterface", package: "AppInterface")
            ]
        ),
        .testTarget(
            name: "FactoryTests",
            dependencies: ["Factory"]
        )
    ]
)
