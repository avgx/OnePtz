import Foundation
import OneWireFormat
import RequestResponse

/// Movement mode query for the legacy HTTP servlet (`control/telemetry/...`).
public enum LegacyTelemetryMode: String, Equatable, Sendable {
    case continuous
    case absolute
    case relative
    case auto
}

/// Legacy PTZ servlet (`GET {prefix}/control/telemetry/...`).
///
/// Used when Native BL `/v1/telemetry` is not mounted. The path uses `AccessPoint.nohosts`.
public enum LegacyTelemetryApi {
    /// Endpoint: `GET control/telemetry/session/acquire/{accessPoint}?session_priority=`
    public static func acquireSession(
        accessPoint: AccessPoint,
        sessionPriority: Int = 1
    ) -> Request<LegacyAcquireSessionResponse> {
        Request(
            path: "control/telemetry/session/acquire/\(accessPoint.nohosts)",
            method: .get,
            query: [
                ("session_priority", String(sessionPriority)),
            ]
        )
    }

    /// Endpoint: `GET control/telemetry/session/keepalive/{accessPoint}?session_id=`
    public static func keepAlive(accessPoint: AccessPoint, sessionId: Int) -> Request<Void> {
        Request(
            path: "control/telemetry/session/keepalive/\(accessPoint.nohosts)",
            method: .get,
            query: [
                ("session_id", String(sessionId)),
            ]
        )
    }

    /// Endpoint: `GET control/telemetry/session/release/{accessPoint}?session_id=`
    public static func releaseSession(accessPoint: AccessPoint, sessionId: Int) -> Request<Void> {
        Request(
            path: "control/telemetry/session/release/\(accessPoint.nohosts)",
            method: .get,
            query: [
                ("session_id", String(sessionId)),
            ]
        )
    }

    /// Endpoint: `GET control/telemetry/move/{accessPoint}?session_id&mode&pan&tilt`
    public static func move(
        accessPoint: AccessPoint,
        sessionId: Int,
        mode: LegacyTelemetryMode,
        pan: Double,
        tilt: Double
    ) -> Request<Void> {
        Request(
            path: "control/telemetry/move/\(accessPoint.nohosts)",
            method: .get,
            query: [
                ("session_id", String(sessionId)),
                ("mode", mode.rawValue),
                ("pan", String(pan)),
                ("tilt", String(tilt)),
            ]
        )
    }
}
