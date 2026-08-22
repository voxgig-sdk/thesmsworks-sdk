// swift-tools-version:5.9
//
// Thesmsworks SDK - SwiftPM manifest. The runtime itself is dependency-free
// (Foundation + the vendored Voxgig Struct port under
// Sources/ProjectNameSDK/Struct); declared feature/target deps (if any)
// appear below.
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
