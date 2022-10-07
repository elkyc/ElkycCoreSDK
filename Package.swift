// swift-tools-version:5.3
import PackageDescription

let version = "2.1.2"
let checksum = "1a98807d53aaa85b6b956faee26957f03c3888ba57b2a1195ae0f50ca00fd259"

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
