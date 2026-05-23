import Foundation

/// PTZ movement mode flags (`axxonsoft.bl.ptz.Capabilities`).
///
/// Source: `TelemetryHelper.proto`. Request body only.
public struct Capabilities: Encodable, Equatable, Sendable {
    public let isRelative: Bool?
    public let isContinuous: Bool?
    public let isAbsolute: Bool?
    public let isAuto: Bool?

    public init(
        isRelative: Bool? = nil,
        isContinuous: Bool? = nil,
        isAbsolute: Bool? = nil,
        isAuto: Bool? = nil
    ) {
        self.isRelative = isRelative
        self.isContinuous = isContinuous
        self.isAbsolute = isAbsolute
        self.isAuto = isAuto
    }

    private enum CodingKeys: String, CodingKey {
        case isRelative = "is_relative"
        case isContinuous = "is_continuous"
        case isAbsolute = "is_absolute"
        case isAuto = "is_auto"
    }
}
