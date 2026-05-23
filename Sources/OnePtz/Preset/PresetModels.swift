import Foundation
import OneWireFormat
import SafeEnum

public struct PresetInfo: Decodable, Equatable, Sendable {
    public let label: String?
    public let position: Int
    public let name: String?
    public let savedOnDevice: Bool?
    public let absolutePan: Int?
    public let absoluteTilt: Int?
    public let absoluteZoom: Int?

    private enum CodingKeys: String, CodingKey {
        case label
        case position
        case name
        case savedOnDevice = "saved_on_device"
        case absolutePan = "absolute_pan"
        case absoluteTilt = "absolute_tilt"
        case absoluteZoom = "absolute_zoom"
    }
}

public struct Preset: Encodable, Equatable, Sendable {
    public let label: String?
    public let savedOnDevice: Bool?
    public let absolutePan: Int?
    public let absoluteTilt: Int?
    public let absoluteZoom: Int?

    public init(
        label: String? = nil,
        savedOnDevice: Bool? = nil,
        absolutePan: Int? = nil,
        absoluteTilt: Int? = nil,
        absoluteZoom: Int? = nil
    ) {
        self.label = label
        self.savedOnDevice = savedOnDevice
        self.absolutePan = absolutePan
        self.absoluteTilt = absoluteTilt
        self.absoluteZoom = absoluteZoom
    }

    private enum CodingKeys: String, CodingKey {
        case label
        case savedOnDevice = "saved_on_device"
        case absolutePan = "absolute_pan"
        case absoluteTilt = "absolute_tilt"
        case absoluteZoom = "absolute_zoom"
    }
}

public struct PresetCollection: Decodable, Equatable, Sendable {
    public let presetInfo: [PresetInfo]

    private enum CodingKeys: String, CodingKey {
        case presetInfo = "preset_info"
    }
}

public struct PresetCollectionResponse: Decodable, Equatable, Sendable {
    public let presetInfo: [PresetInfo]?
    public let errorCode: SafeEnum<PresetCollectionErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case presetInfo = "preset_info"
        case errorCode = "error_code"
    }
}

/// Query parameters for `GET /v1/telemetry/presets`.
public struct GetPresetsInfoRequest: Equatable, Sendable {
    public let accessPoint: AccessPoint

    public init(accessPoint: AccessPoint) {
        self.accessPoint = accessPoint
    }
}

public struct SetPresetRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let position: Int
    public let label: String?

    public init(
        accessPoint: AccessPoint,
        sessionId: Int,
        position: Int,
        label: String? = nil
    ) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.position = position
        self.label = label
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case position
        case label
    }
}

public struct SetPresetResponse: Decodable, Equatable, Sendable {
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}

public struct ConfigurePresetRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let position: Int
    public let preset: Preset

    public init(accessPoint: AccessPoint, position: Int, preset: Preset) {
        self.accessPoint = accessPoint
        self.position = position
        self.preset = preset
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case position
        case preset
    }
}

public struct GoPresetRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let position: Int
    public let speed: Double?

    public init(
        accessPoint: AccessPoint,
        sessionId: Int,
        position: Int,
        speed: Double? = nil
    ) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.position = position
        self.speed = speed
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case position
        case speed
    }
}

public struct RemovePresetRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let position: Int

    public init(accessPoint: AccessPoint, sessionId: Int, position: Int) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.position = position
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case position
    }
}
