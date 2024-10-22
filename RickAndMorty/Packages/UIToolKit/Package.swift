// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIToolKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "UIToolKit",
            targets: ["UIToolKit"]
        ),
    ],
    dependencies: [
        .package(path: "../Core"),
    ],
    targets: [
        .target(
            name: "UIToolKit",
            dependencies: ["Core"],
            path: "Sources"
        ),
        .testTarget(
            name: "UIToolKitTests",
            dependencies: ["UIToolKit"],
            path: "Tests"
        )
    ]
)
