// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "TOPasscodeViewController",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "TOPasscodeViewController",
            targets: [
                "TOPasscodeViewController"
            ]
        ),
    ],
    targets: [
        .target(
            name: "TOPasscodeViewController",
            path: "TOPasscodeViewController",
            cSettings: [
                .headerSearchPath("Models"),
                .headerSearchPath("Supporting"),
                .headerSearchPath("Views/Main"),
                .headerSearchPath("Views/Settings"),
                .headerSearchPath("Views/Shared")
            ]
        )
    ]
)
