// swift-tools-version:5.3
import PackageDescription

let version = "2.1.4"
let checksum = "17ca606712d993d152db1f7229e1cb50af353cd7604bbeb2a20489aa512c4fea"

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
