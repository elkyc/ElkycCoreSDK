// swift-tools-version:5.3
import PackageDescription

let version = "2.1.0"
let checksum = "fabd8b5793850a1125050aaf11a5402762bed8f3633ecbf886e9187b72d2291d"

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
