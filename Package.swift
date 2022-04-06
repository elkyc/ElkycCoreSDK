// swift-tools-version:5.3
import PackageDescription

let version = "1.2.9"
let checksum = "bce77919ce0c305dcc6f4f80db12283bdefd84ca65fe56cf9c0566ef33c901fc"

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
