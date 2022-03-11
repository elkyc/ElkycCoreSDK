// swift-tools-version:5.3
import PackageDescription

let version = "1.2.4"
let checksum = "be9c10fce01a774d6b80a97981e0ebe6fb78cfda23c924966f5a24c2bdf26e7e"

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