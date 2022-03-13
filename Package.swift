// swift-tools-version:5.3
import PackageDescription

let version = "1.2.5"
let checksum = "b819193769eb4ee2164854d7d247fea1c5a5d6a598522190ce3f8cae4350e743"

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