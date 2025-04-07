// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SegmentButtonKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "SegmentButtonKit", targets: ["SegmentButtonKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SegmentButtonKit",
            dependencies: []
        )
    ]
)