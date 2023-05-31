// swift-tools-version:5.3
import PackageDescription

let version = "2.2.0"
let checksum = "bb3bf3af40e40ff3dd791e71ad13c7e029495db2c812ce0aae642ba93fa39235"

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
