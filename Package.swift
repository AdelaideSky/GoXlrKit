// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoXlrKit",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GoXlrKit",
            targets: ["GoXlrKit"]),
        .library(
            name: "GoXlrKit-Audio",
            targets: ["GoXlrKit-Audio"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/daltoniam/Starscream", branch: "master"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", branch: "master"),
        .package(url: "https://github.com/rnine/SimplyCoreAudio", branch: "develop"),
        .package(url: "https://github.com/AdelaideSky/SkyKit", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GoXlrKit",
            dependencies: ["Starscream", "SwiftyJSON", .product(name: "SkyKitC", package: "SkyKit"), .product(name: "SkyKit", package: "SkyKit")],
            resources: [.copy("Resources/Library")]),
        .target(
            name: "GoXlrKit-Audio",
            dependencies: ["SimplyCoreAudio"])
    ],
    swiftLanguageVersions: [.v5]
)
