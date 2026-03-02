// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppDomain",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AppDomain",
                 targets: ["AppDomain"]),
    ],
    dependencies: [
//        .package(path: "../Services")
    ],
    targets: [
        .target(
            name: "AppDomain",
            dependencies: [
 //               .product(name: "Services", package: "Services")
            ]
        ),
        .testTarget(
            name: "AppDomainTests",
            dependencies: ["AppDomain"]
        )
    ]
)
