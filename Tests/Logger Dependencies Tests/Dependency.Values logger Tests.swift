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

import Dependencies_Test_Support
import Logging
import Testing

@testable import Logger_Dependencies

@Suite
struct `Dependency Values logger Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Dependency Values logger Tests`.Unit {
    @Test
    func `test context resolves a no-op logger`() {
        withDependencies(mode: .test) { _ in
        } operation: {
            @Dependency(\.logger) var logger

            #expect(logger.label == "swift-logger-dependencies")
            #expect(logger.logLevel == .critical)
            logger.critical("discarded")
        }
    }
}

extension `Dependency Values logger Tests`.`Edge Case` {
    #if DEBUG
        @Test
        func `missing live registration triggers the dependency tripwire`() async {
            await #expect(processExitsWith: .failure) {
                withDependencies(mode: .live) { _ in
                } operation: {
                    @Dependency(\.logger) var logger
                    _ = logger
                }
            }
        }
    #endif
}

extension `Dependency Values logger Tests`.Integration {
    @Test
    func `explicit live override supplies the registered logger`() {
        let registered = Logger(label: "application") { _ in
            SwiftLogNoOpLogHandler()
        }

        withDependencies(mode: .live) {
            $0.logger = registered
        } operation: {
            @Dependency(\.logger) var logger

            #expect(logger.label == "application")
        }
    }
}
