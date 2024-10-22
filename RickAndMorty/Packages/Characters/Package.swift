// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Characters",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Characters",
            targets: ["Characters"]
        ),
    ],
    dependencies: [
        .package(path: "../Networking"),
        .package(path: "../Core"),
        .package(path: "../UIToolKit")
    ],
    targets: [
        .target(
            name: "Characters",
            dependencies: ["Networking", "Core", "UIToolKit"],
            path: "Sources"
        ),
        .testTarget(
            name: "CharactersTests",
            dependencies: ["Characters"],
            path: "Tests"
        )
    ]
)
