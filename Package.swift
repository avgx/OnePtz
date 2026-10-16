// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "OnePtz",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "OnePtz",
            targets: ["OnePtz"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/avgx/RequestResponse", from: "2.0.0"),
        .package(url: "https://github.com/avgx/SafeEnum", from: "1.0.0"),
        .package(url: "https://github.com/avgx/OneWireFormat", from: "1.0.0"),
        .package(url: "https://github.com/avgx/Get", branch: "dev"),
        .package(url: "https://github.com/avgx/OneDomain", branch: "main"),
        .package(url: "https://github.com/avgx/EncodeDecode", from: "1.0.5"),
    ],
    targets: [
        .target(
            name: "OnePtz",
            dependencies: [
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "SafeEnum", package: "SafeEnum"),
                .product(name: "OneWireFormat", package: "OneWireFormat"),
            ]
        ),
        .testTarget(
            name: "OnePtzTests",
            dependencies: [
                "OnePtz",
                .product(name: "OneWireFormat", package: "OneWireFormat"),
            ]
        ),
        .testTarget(
            name: "OnePtzIntegrationTests",
            dependencies: [
                "OnePtz",
                .product(name: "OneDomain", package: "OneDomain"),
                .product(name: "HTTP", package: "Get"),
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "EncodeDecode", package: "EncodeDecode"),
            ],
            path: "Tests/OnePtzIntegrationTests"
        ),
    ]
)
