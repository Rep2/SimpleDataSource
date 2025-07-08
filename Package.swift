// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SimpleDataSource",
    platforms: [
       .iOS(.v12)
    ],
    products: [
        .library(
            name: "SimpleDataSource",
            targets: ["SimpleDataSource"]
        ),
    ],
    targets: [
        .target(
            name: "SimpleDataSource"
        )
    ]
)
