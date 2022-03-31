// swift-tools-version:5.3
import PackageDescription

let version = "1.2.8"
let checksum = "4919bd9be6d3f6d2b6a1c3c616a658a3efae45e59f83b6882ff1224972e264cd"

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
