// swift-tools-version:5.3
import PackageDescription

let version = "2.1.1"
let checksum = "0a37d7a5b4274575cb21c8429dad313f9738022cad0de89f6a28384be00262ef"

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
