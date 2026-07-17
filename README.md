# swift-logger-dependencies

![Development Status](https://img.shields.io/badge/status-active--development-orange.svg)

A `Logger` dependency value for [swift-dependencies](https://github.com/swift-foundations/swift-dependencies).

> The Logger × Dependencies integration package: one home for
> `Logging.Logger` as a dependency value. Applications configure a logger at
> their composition root; libraries consume it through `@Dependency(\.logger)`.

## Overview

`import Logger_Dependencies` provides `@Dependency(\.logger)` with a deliberately
strict live boundary:

| Context | Resolves to | Behavior |
|---------|-------------|----------|
| Live | composition-root override | missing registration triggers the dependency live-context tripwire |
| Preview | no-op logger | discards log events |
| Test | no-op logger | discards log events unless explicitly overridden |

This package does not configure logging or choose a production log handler.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-logger-dependencies.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Logger Dependencies", package: "swift-logger-dependencies")
    ]
)
```

## Quick Start

```swift
import Logger_Dependencies

withDependencies {
    $0.logger = applicationLogger
} operation: {
    @Dependency(\.logger) var logger
    logger.info("Application started")
}
```

## License

Licensed under the [Apache License, Version 2.0](LICENSE.md).
