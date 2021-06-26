// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RemoteData",
    // platforms: [ .iOS(.v13) ],
    products: [
        .library(name: "RemoteData", targets: ["RemoteData"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RemoteData",
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "RemoteDataTests",
            dependencies: ["RemoteData"],
            exclude: ["Info.plist"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
