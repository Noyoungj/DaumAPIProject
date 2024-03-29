// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyPakage",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MyPakage",
            targets: ["MyPakage"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.5.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.37.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MyPakage",
            dependencies: [.product(name: "SnapKit", package: "SnapKit"),
                           .product(name: "Moya", package: "Moya"),
                           .product(name: "RxSwift", package: "RxSwift"),
                           .product(name: "RxCocoa", package: "RxSwift"),
                           .product(name: "Kingfisher", package: "Kingfisher"),
                           .product(name: "RealmSwift", package: "realm-swift"),
                           .product(name: "RxDataSources", package: "RxDataSources")
            ]),
        .testTarget(
            name: "MyPakageTests",
            dependencies: ["MyPakage"]),
    ]
)
