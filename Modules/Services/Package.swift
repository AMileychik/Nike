// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Services",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Services", 
                 targets: ["Services"]),
    ],
    dependencies: [
        .package(path: "../AppInterface"),
        .package(path: "../AppDomain")
    ],
    targets: [
        .target(
            name: "Services",
            dependencies: [
                .product(name: "AppInterface", package: "AppInterface"),
                .product(name: "AppDomain", package: "AppDomain")
            ],
            path: "Sources/Services"
        )
    ]
)
