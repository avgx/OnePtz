import Foundation

/// Response of `GET control/telemetry/session/acquire/{accessPoint}`.
public struct LegacyAcquireSessionResponse: Decodable, Equatable, Sendable {
    public let sessionId: Int

    private enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
    }
}
