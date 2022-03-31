// swift-tools-version:5.3
import PackageDescription

let version = "1.2.7"
let checksum = "f63bdb289b8b93fb4cdc601475280a7c83ebdb4a6c87b2b879cc4688c8a05a5f"

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
            url: "https://github.com/elkyc/ElkycCoreSDK/releases/download/v\(version)/ElkycCoreSDK.xcframework.zip",
            checksum: checksum)
    ]
)
