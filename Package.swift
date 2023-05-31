// swift-tools-version:5.3
import PackageDescription

let version = "2.2.0"
let checksum = "46ba5263703ef20fdf4943e2d623f45a2b6515ded409222202122ff35f9d17e9"

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
