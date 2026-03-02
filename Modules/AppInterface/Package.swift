// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AppInterface",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AppInterface",
            targets: ["AppInterface"]),
    ],
    dependencies: [
        .package(path: "../AppDomain")
    ],
    targets: [
        .target(
            name: "AppInterface",
            dependencies: [
                .product(name: "AppDomain", package: "AppDomain")            
            ]
        ),
        .testTarget(
            name: "AppInterfaceTests",
            dependencies: ["AppInterface"]),
    ]
)
