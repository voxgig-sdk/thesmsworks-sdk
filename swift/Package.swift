// swift-tools-version:5.9
//
// Thesmsworks SDK - SwiftPM manifest. Zero runtime dependencies (Foundation +
// the vendored Voxgig Struct port under Sources/ProjectNameSDK/Struct).
import PackageDescription

let package = Package(
    name: "ThesmsworksSdk",
    products: [
        .library(name: "ThesmsworksSdk", targets: ["ThesmsworksSdk"]),
    ],
    targets: [
        .target(
            name: "ThesmsworksSdk",
            path: "Sources/ProjectNameSDK"),
        .testTarget(
            name: "ThesmsworksSdkTests",
            dependencies: ["ThesmsworksSdk"],
            path: "Tests/ProjectNameSDKTests"),
    ]
)
