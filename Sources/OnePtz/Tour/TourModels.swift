import Foundation
import OneWireFormat
import SafeEnum

public enum TourState: String, Decodable, Equatable, Sendable {
    case unspecified = "TOUR_STATE_UNSPECIFIED"
    case idle = "EIdle"
    case touring = "ETouring"
    case paused = "EPaused"
    case extended = "EExtended"
}

/// Query parameters for `GET /v1/telemetry/tours`.
public struct GetToursRequest: Equatable, Sendable {
    public let accessPoint: AccessPoint

    public init(accessPoint: AccessPoint) {
        self.accessPoint = accessPoint
    }
}

public struct GetToursResponse: Decodable, Equatable, Sendable {
    public struct Tour: Decodable, Equatable, Sendable {
        public let name: String
        public let state: SafeEnum<TourState>?

        private enum CodingKeys: String, CodingKey {
            case name
            case state
        }
    }

    public let errorCode: SafeEnum<PresetCollectionErrorCode>?
    public let tours: [Tour]?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case tours
    }
}

/// Query parameters for `GET /v1/telemetry/tours/points`.
public struct GetTourPointsRequest: Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let tourName: String

    public init(accessPoint: AccessPoint, tourName: String) {
        self.accessPoint = accessPoint
        self.tourName = tourName
    }
}

public struct GetTourPointsResponse: Decodable, Equatable, Sendable {
    public let presetCollection: PresetCollection?
    public let errorCode: SafeEnum<PresetCollectionErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case presetCollection = "preset_collection"
        case errorCode = "error_code"
    }
}

public struct PlayTourRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let tourName: String

    public init(accessPoint: AccessPoint, sessionId: Int, tourName: String) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.tourName = tourName
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case tourName = "tour_name"
    }
}

public struct PlayTourResponse: Decodable, Equatable, Sendable {
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}

public struct StopTourRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let tourName: String

    public init(accessPoint: AccessPoint, sessionId: Int, tourName: String) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.tourName = tourName
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case tourName = "tour_name"
    }
}

public struct StopTourResponse: Decodable, Equatable, Sendable {
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}

public struct StartFillTourRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let tourName: String

    public init(accessPoint: AccessPoint, sessionId: Int, tourName: String) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.tourName = tourName
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case tourName = "tour_name"
    }
}

public struct StartFillTourResponse: Decodable, Equatable, Sendable {
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}

public struct SetTourPointRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let presetName: String
    public let dwellTime: Int
    public let moveSpeed: Int

    public init(
        accessPoint: AccessPoint,
        sessionId: Int,
        presetName: String,
        dwellTime: Int,
        moveSpeed: Int
    ) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.presetName = presetName
        self.dwellTime = dwellTime
        self.moveSpeed = moveSpeed
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case presetName = "preset_name"
        case dwellTime = "dwell_time"
        case moveSpeed = "move_speed"
    }
}

public struct SetTourPointResponse: Decodable, Equatable, Sendable {
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}

public struct StopFillTourRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let tourName: String

    public init(accessPoint: AccessPoint, sessionId: Int, tourName: String) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.tourName = tourName
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case tourName = "tour_name"
    }
}

public struct StopFillTourResponse: Decodable, Equatable, Sendable {
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}

public struct RemoveTourRequest: Encodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let sessionId: Int
    public let tourName: String

    public init(accessPoint: AccessPoint, sessionId: Int, tourName: String) {
        self.accessPoint = accessPoint
        self.sessionId = sessionId
        self.tourName = tourName
    }

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case sessionId = "session_id"
        case tourName = "tour_name"
    }
}

public struct RemoveTourResponse: Decodable, Equatable, Sendable {
    public let errorCode: SafeEnum<TelemetryErrorCode>?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}
