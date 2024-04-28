// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AUNetworking",
    platforms: [
        .macOS(.v10_15),.iOS(.v13) // minimum iOS, macOS version
    ], products: [
        .library(
            name: "AUNetworking",
            targets: ["AUNetworking"]),
    ],
    targets: [
        .target(
            name: "AUNetworking",
            path: "Sources")
    ]
)
