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

    public var logger: Logger {
        get { self[Key.self] }
        set { self[Key.self] = newValue }
    }
}
