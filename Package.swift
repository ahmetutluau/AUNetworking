// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AUNetworking",
    products: [
        .library(
            name: "AUNetworking",
            targets: ["AUNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.0"))
    ],
    targets: [
        .target(
            name: "AUNetworking",
            dependencies: ["Alamofire"],
            path: "Sources")
    ]
)
