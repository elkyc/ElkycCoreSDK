// swift-tools-version:5.3
import PackageDescription

let version = "1.2.6"
let checksum = "73e6e99a6cd25072598257e99a00baa7a07219de7bdbfd6d575ebfdaab3ae37e"

let package = Package(
    name: "ElkycCoreSDK",
    products: [
        .library(
            name: "ElkycCoreSDK",
            targets: ["ElkycCoreSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "ElkycCoreSDK",
            url: "https://github.com/elkyc/ElkycCoreSDK/releases/download/v1.2.6/ElkycCoreSDK.xcframework.zip",
            checksum: "73e6e99a6cd25072598257e99a00baa7a07219de7bdbfd6d575ebfdaab3ae37e")
    ]
)
