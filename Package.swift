// swift-tools-version:5.3
import PackageDescription

let version = "2.1.3"
let checksum = "d14302130c1bf2d22fb525cf7d0853a487e60c9a14f66e1488266092a3260b16"

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
