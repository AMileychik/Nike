// swift-tools-version: 5.10

import PackageDescription

// MARK: - Local Modules

enum Module {
    static let appDomain = "AppDomain"
    static let designSystem = "DesignSystem"
    static let appInterface = "AppInterface"
    static let appComposition = "AppComposition"
    static let detail = "Detail"
    static let bag = "Bag"
    static let appCore = "AppCore"
}

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]
        ),
    ],
    dependencies: [
        // Local feature modules
        .package(path: "../\(Module.appDomain)"),
        .package(path: "../\(Module.designSystem)"),
        .package(path: "../\(Module.appInterface)"),
        .package(path: "../\(Module.appComposition)"),
        .package(path: "../\(Module.detail)"),
        .package(path: "../\(Module.bag)"),
        .package(path: "../\(Module.appCore)")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                .product(name: Module.appDomain, package: Module.appDomain),
                .product(name: Module.designSystem, package: Module.designSystem),
                .product(name: Module.appInterface, package: Module.appInterface),
                .product(name: Module.appComposition, package: Module.appComposition),
                .product(name: Module.detail, package: Module.detail),
                .product(name: Module.bag, package: Module.bag),
                .product(name: Module.appCore, package: Module.appCore)
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]
        )
    ]
)
