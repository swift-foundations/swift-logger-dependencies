// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-logger-dependencies open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-logger-dependencies
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

public import Dependencies
public import Logging

private enum Key: Dependency.Key.Test {}

extension Key {
    static var testValue: Logger {
        Logger(label: "swift-logger-dependencies") { _ in
            SwiftLogNoOpLogHandler()
        }
    }
}

extension Dependency.Values {
    /// The logger registered by the application composition root.
    ///
    /// Test and preview contexts default to a no-op logger. Live contexts
    /// require an explicit override and trigger the dependency live-context
    /// tripwire when registration is missing.
    public var logger: Logger {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
