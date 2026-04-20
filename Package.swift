// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "uto",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "uto", targets: ["uto"]),
    ],
    targets: [
        .target(
            name: "uto",
            path: "src"
        ),
    ]
)
