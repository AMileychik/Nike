// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Shop",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "ShopCoordinator", targets: ["ShopCoordinator"]),
        .library(name: "ShopUI", targets: ["ShopUI"]),
        .library(name: "ShopPresenter", targets: ["ShopPresenter"]),
        .library(name: "ShopDomain", targets: ["ShopDomain"]),
        .library(name: "ShopCore", targets: ["ShopCore"])
    ],
    dependencies: [
        .package(path: "../AppCore"),
        .package(path: "../AppInterface"),
        .package(path: "../AppDomain"),
        .package(path: "../DesignSystem"),
    ],
    targets: [
        .target(
            name: "ShopCore",
              dependencies: [
                .product(name: "AppDomain", package: "AppDomain")
              ],
            path: "Sources/Shop/ShopCore"
        ),
        .target(
            name: "ShopCoordinator",
            dependencies: [
                "ShopDomain",
                .product(name: "AppInterface", package: "AppInterface")
            ],
            path: "Sources/Shop/ShopCoordinator"
        ),
        .target(
            name: "ShopUI",
            dependencies: [
                "ShopCore",
                .product(name: "AppCore", package: "AppCore")
            ],
            path: "Sources/Shop/ShopUI"
        ),
        .target(
            name: "ShopDomain",
            dependencies: [
                "ShopUI",
                "ShopCore"
            ],
            path: "Sources/Shop/ShopDomain"
        ),
        .target(
            name: "ShopPresenter",
            dependencies: [
                "ShopDomain",
                .product(name: "AppCore", package: "AppCore"),
                .product(name: "AppInterface", package: "AppInterface"),
                .product(name: "AppDomain", package: "AppDomain"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ],
            path: "Sources/Shop/ShopPresenter"
        )
    ]
)
