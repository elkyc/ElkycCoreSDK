// swift-tools-version:5.3
import PackageDescription

let version = "1.3.0"
let checksum = "4c94bb6f46ad5970e3f37ab2c44dabe44704d00f52b66b618f59acdaea7d4b66"

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
