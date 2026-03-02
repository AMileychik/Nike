// swift-tools-version: 5.7

//import PackageDescription
//
//let package = Package(
//    name: "Services",
//    platforms: [
//        .iOS(.v15)
//    ],
//    products: [
//        .library(name: "Services", 
//                 targets: ["Services"]),
//    ],
//    dependencies: [
//        .package(path: "../AppInterface"),
//        .package(path: "../AppDomain")
//    ],
//    targets: [
//        .target(
//            name: "Services",
//            dependencies: [
//                .product(name: "AppInterface", package: "AppInterface"),
//                .product(name: "AppDomain", package: "AppDomain")
//            ],
//            path: "Sources/Services"
//        ),
//        .testTarget(
//            name: "ServicesTests",
//            dependencies: ["Services"],
//            path: "Tests/ServicesTests"
//        )
//    ]
//)


import PackageDescription

let package = Package(
    name: "Services",
    platforms: [
        .iOS("15.0") // <-- указываем здесь минимальную iOS для всего пакета
    ],
    products: [
        .library(
            name: "Services",
            targets: ["Services"]
        ),
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
        ),
//        .testTarget(
//            name: "ServicesTests",
//            dependencies: ["Services"],
//            path: "Tests/ServicesTests"
//        )
        .testTarget(
            name: "ServicesTests",
            dependencies: ["Services"],
            path: "Tests/ServicesTests",
            swiftSettings: [
                .define("IS_IOS")
            ]
        )
    ]
)
