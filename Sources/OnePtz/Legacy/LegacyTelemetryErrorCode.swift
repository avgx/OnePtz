import Foundation

/// Servlet PTZ error (`{"error_code": N}` on `control/telemetry/...`).
///
/// Same numbering as the Android `TelemetryNext` notes:
/// 1 general, 2 bad parameters, 3 session unavailable, 4 preset.
public enum LegacyTelemetryErrorCode: Int, Equatable, Sendable {
    case general = 1
    case invalidParameters = 2
    case sessionUnavailable = 3
    case preset = 4

    public static func decode(_ body: Data) -> LegacyTelemetryErrorCode? {
        guard let json = try? JSONSerialization.jsonObject(with: body) as? [String: Any] else {
            return nil
        }
        let raw: Int?
        if let code = json["error_code"] as? Int {
            raw = code
        } else if let code = json["error_code"] as? NSNumber {
            raw = code.intValue
        } else {
            raw = nil
        }
        guard let raw else { return nil }
        return LegacyTelemetryErrorCode(rawValue: raw)
    }

    public var logName: String {
        switch self {
        case .general: return "general"
        case .invalidParameters: return "invalidParameters"
        case .sessionUnavailable: return "sessionUnavailable"
        case .preset: return "preset"
        }
    }

    public var userMessage: String {
        switch self {
        case .general:
            return "PTZ command failed (general error)."
        case .invalidParameters:
            return "PTZ request parameters are invalid."
        case .sessionUnavailable:
            return "PTZ session unavailable."
        case .preset:
            return "PTZ preset error."
        }
    }
}
