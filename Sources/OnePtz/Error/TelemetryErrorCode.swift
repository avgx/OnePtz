import Foundation

/// PTZ command error code (`axxonsoft.bl.ptz.EErrorCode`).
public enum TelemetryErrorCode: String, Decodable, Equatable, Sendable {
    case notError = "NotError"
    case sessionUnavailable = "SessionUnavailable"
    case generalError = "GeneralError"
    case presetError = "PresetError"
    case unsupportedCommand = "UnsupportedCommand"
}

/// Preset/tour collection error code (`PresetCollectionResponse.EErrorCode`, `GetToursResponse.EErrorCode`, …).
public enum PresetCollectionErrorCode: String, Decodable, Equatable, Sendable {
    case notError = "NotError"
    case xDeviceBusyError = "XDeviceBusyError"
}
