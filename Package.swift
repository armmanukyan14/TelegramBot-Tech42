// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "tgbot",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/nerzh/telegram-vapor-bot", .upToNextMajor(from: "1.0.2")),
//        .package(url: "https://github.com/apple/swift-nio.git", from: "2.34.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
//                .library(name: "NIOExtras", targets: ["NIOExtras"]),
//                .library(name: "NIOSOCKS", targets: ["NIOSOCKS"]),
//                .library(name: "NIOHTTPCompression", targets: ["NIOHTTPCompression"]),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "telegram-vapor-bot", package: "telegram-vapor-bot"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
