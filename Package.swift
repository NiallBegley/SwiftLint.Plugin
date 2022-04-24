// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftLint.Plugin",
    products: [
        .plugin(name: "SwiftLint.Plugin", targets: ["SwiftLintBuildTool"]),
        .plugin(name: "swiftlint", targets: ["SwiftLintCommand"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
//        .package(url: "https://github.com/usami-k/SwiftLintPlugin", branch: "main")
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/juozasvalancius/SwiftLint/releases/download/spm-accommodation/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "cdc36c26225fba80efc3ac2e67c2e3c3f54937145869ea5dbcaa234e57fc3724"),

        .plugin(
            name: "SwiftLintBuildTool",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]),

        .plugin(
            name: "SwiftLintCommand",
            capability: .command(intent: .custom(verb: "swiftlint", description: "Swiftlint")),
            dependencies: ["SwiftLintBinary"])
    ]
)
