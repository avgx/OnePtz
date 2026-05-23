import Foundation
import OneWireFormat
import SafeEnum

public struct SessionInformation: Decodable, Equatable, Sendable {
    public let subjectName: String
    public let hostName: String

    private enum CodingKeys: String, CodingKey {
        case subjectName = "subject_name"
        case hostName = "host_name"
    }
}

/// Query parameters for `GET /v1/telemetry/sessions`.
public struct AcquireSessionRequest: Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let hostName: String

    public init(accessPoint: AccessPoint, hostName: String) {
        self.accessPoint = accessPoint
        self.hostName = hostName
    }
}

public struct AcquireSessionResponse: Decodable, Equatable, Sendable {
    public let sessionId: Int
    public let errorCode: SafeEnum<TelemetryErrorCode>?
    public let expirationTime: String?
    public let sessionInfo: SessionInformation?

    private enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case errorCode = "error_code"
        case expirationTime = "expiration_time"
        case sessionInfo = "session_info"
    }
}

public struct SessionRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int

    public init(accessPoint: AccessPoint, sessionId: Int) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
    }
}

public struct KeepAliveResponse: Decodable, Equatable, Sendable {
    public let result: Bool
    public let expirationTime: String?

    private enum CodingKeys: String, CodingKey {
        case result
        case expirationTime = "expiration_time"
    }
}

public struct IsSessionAvailableRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint

    public init(accessPoint: AccessPoint) {
        self.accessPoint = accessPoint
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
    }
}

public struct IsSessionAvailableResponse: Decodable, Equatable, Sendable {
    public let isAvailable: Bool
    public let sessionInfo: SessionInformation?

    private enum CodingKeys: String, CodingKey {
        case isAvailable = "is_available"
        case sessionInfo = "session_info"
    }
}
