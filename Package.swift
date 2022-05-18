// swift-tools-version:5.3
import PackageDescription

let version = "2.0.0"
let checksum = "da938f954b4ab18c5184a47e9e2c5764c54d1170dbe6c6bfd0fb445a3347e9f6"

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
