import Foundation
import OneWireFormat

public struct SessionID: Encodable, Equatable, Sendable {
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

public struct MoveRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let mode: Capabilities?
    public let valPan: Double
    public let valTilt: Double

    public init(
        accessPoint: AccessPoint,
        sessionId: Int,
        mode: Capabilities? = nil,
        valPan: Double,
        valTilt: Double
    ) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.mode = mode
        self.valPan = valPan
        self.valTilt = valTilt
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case mode
        case valPan = "val_pan"
        case valTilt = "val_tilt"
    }
}

public struct CommonRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let mode: Capabilities?
    public let value: Double

    public init(
        accessPoint: AccessPoint,
        sessionId: Int,
        mode: Capabilities? = nil,
        value: Double
    ) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.mode = mode
        self.value = value
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case mode
        case value
    }
}

public struct PointMoveRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let point: Point

    public init(accessPoint: AccessPoint, sessionId: Int, point: Point) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.point = point
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case point
    }
}

public struct AreaZoomRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let rectangle: Rectangle

    public init(accessPoint: AccessPoint, sessionId: Int, rectangle: Rectangle) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.rectangle = rectangle
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case rectangle
    }
}
