import Foundation
import OneWireFormat
import SafeEnum

public struct AbsolutePosition: Codable, Equatable, Sendable {
    public let pan: Int
    public let tilt: Int
    public let zoom: Int
    public let mask: Int

    public init(pan: Int, tilt: Int, zoom: Int, mask: Int) {
        self.pan = pan
        self.tilt = tilt
        self.zoom = zoom
        self.mask = mask
    }

    private enum CodingKeys: String, CodingKey {
        case pan
        case tilt
        case zoom
        case mask
    }
}

public struct AbsolutePositionNormalized: Codable, Equatable, Sendable {
    public let pan: Double
    public let tilt: Double
    public let zoom: Double
    public let mask: Int

    public init(pan: Double, tilt: Double, zoom: Double, mask: Int) {
        self.pan = pan
        self.tilt = tilt
        self.zoom = zoom
        self.mask = mask
    }

    private enum CodingKeys: String, CodingKey {
        case pan
        case tilt
        case zoom
        case mask
    }
}

public struct AbsoluteMoveRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let absolutePosition: AbsolutePosition

    public init(accessPoint: AccessPoint, sessionId: Int, absolutePosition: AbsolutePosition) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.absolutePosition = absolutePosition
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case absolutePosition = "absolute_position"
    }
}

public struct AbsoluteMoveNormalizedRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let absolutePosition: AbsolutePositionNormalized

    public init(
        accessPoint: AccessPoint,
        sessionId: Int,
        absolutePosition: AbsolutePositionNormalized
    ) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.absolutePosition = absolutePosition
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case absolutePosition = "absolute_position"
    }
}

/// Query parameters for `GET /v1/telemetry/position`.
public struct GetPositionInformationRequest: Equatable, Sendable {
    public let accessPoint: AccessPoint

    public init(accessPoint: AccessPoint) {
        self.accessPoint = accessPoint
    }
}

public struct GetPositionInformationResponse: Decodable, Equatable, Sendable {
    public let absolutePosition: AbsolutePosition?
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case absolutePosition = "absolute_position"
        case errorCode = "error_code"
    }
}

public struct GetPositionInformationNormalizedResponse: Decodable, Equatable, Sendable {
    public let absolutePosition: AbsolutePositionNormalized?

    private enum CodingKeys: String, CodingKey {
        case absolutePosition = "absolute_position"
    }
}
