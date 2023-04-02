// swift-tools-version:5.3
import PackageDescription

let version = "2.1.5"
let checksum = "837c307a632106e70a6d832a17fe1d3f7bc3c235228a700f20f2c90f994517ae"

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
