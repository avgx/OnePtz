import Foundation
import OneWireFormat

/// Query parameters for `GET /v1/telemetry/operations`.
public struct GetAuxiliaryOperationsRequest: Equatable, Sendable {
    public let accessPoint: AccessPoint

    public init(accessPoint: AccessPoint) {
        self.accessPoint = accessPoint
    }
}

public struct GetAuxiliaryOperationsResponse: Decodable, Equatable, Sendable {
    public let operations: [String]?

    private enum CodingKeys: String, CodingKey {
        case operations
    }
}

public struct PerformAuxiliaryOperationRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let operation: String

    public init(accessPoint: AccessPoint, sessionId: Int, operation: String) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.operation = operation
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case operation
    }
}

public struct PerformAuxiliaryOperationResponse: Decodable, Equatable, Sendable {}
