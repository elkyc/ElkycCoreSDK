// swift-tools-version:5.3
import PackageDescription

let version = "1.3.1"
let checksum = "c0990eac9989d755cb2dbe5686a2bf19206e0e646d1492b3c4862641a7dff9ed"

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
