import Foundation

/// Parsed Native BL / gRPC-JSON telemetry error body (`errorMessage`, `grpcErrorCode`).
///
/// Describes the payload only. Callers that hold an HTTP error unwrap the body and status first.
public enum TelemetryHTTPErrorBody {
    public struct Payload: Equatable, Sendable {
        public var errorMessage: String?
        public var grpcErrorCode: Int?

        public init(errorMessage: String? = nil, grpcErrorCode: Int? = nil) {
            self.errorMessage = errorMessage
            self.grpcErrorCode = grpcErrorCode
        }
    }

    public static func decode(_ body: Data) -> Payload? {
        guard let json = try? JSONSerialization.jsonObject(with: body) as? [String: Any] else {
            return nil
        }
        var payload = Payload()
        payload.errorMessage = json["errorMessage"] as? String
        if let code = json["grpcErrorCode"] as? Int {
            payload.grpcErrorCode = code
        } else if let code = json["grpcErrorCode"] as? NSNumber {
            payload.grpcErrorCode = code.intValue
        }
        return payload
    }

    /// Prettified `errorMessage` when the body carries one.
    public static func userFacingMessage(body: Data) -> String? {
        guard let message = decode(body)?.errorMessage?.trimmingCharacters(in: .whitespacesAndNewlines),
              !message.isEmpty
        else { return nil }
        return prettifyTelemetryMessage(message)
    }

    /// `errorMessage`, gRPC code name, and HTTP status. Nil when the body is not a telemetry error payload.
    public static func logDetail(body: Data, statusCode: Int?) -> String? {
        guard let payload = decode(body) else { return nil }
        var parts: [String] = []
        if let message = payload.errorMessage, !message.isEmpty {
            parts.append(message)
        }
        if let code = payload.grpcErrorCode {
            parts.append("grpc=\(code) (\(grpcCodeName(code)))")
        }
        if let statusCode {
            parts.append("http=\(statusCode)")
        }
        return parts.isEmpty ? nil : parts.joined(separator: " ")
    }

    /// Native `/v1/telemetry` is not mounted.
    ///
    /// `grpcErrorCode == 12` (UNIMPLEMENTED), or HTTP 404/501 with no gRPC code.
    /// Any other gRPC code, including 5 (NOT_FOUND), means the method exists.
    public static func isNativeRouteMissing(body: Data, statusCode: Int) -> Bool {
        if let code = decode(body)?.grpcErrorCode {
            return code == 12
        }
        return statusCode == 404 || statusCode == 501
    }

    public static func grpcCodeName(_ code: Int) -> String {
        switch code {
        case 0: return "OK"
        case 1: return "CANCELLED"
        case 2: return "UNKNOWN"
        case 3: return "INVALID_ARGUMENT"
        case 4: return "DEADLINE_EXCEEDED"
        case 5: return "NOT_FOUND"
        case 6: return "ALREADY_EXISTS"
        case 7: return "PERMISSION_DENIED"
        case 8: return "RESOURCE_EXHAUSTED"
        case 9: return "FAILED_PRECONDITION"
        case 10: return "ABORTED"
        case 11: return "OUT_OF_RANGE"
        case 12: return "UNIMPLEMENTED"
        case 13: return "INTERNAL"
        case 14: return "UNAVAILABLE"
        case 15: return "DATA_LOSS"
        case 16: return "UNAUTHENTICATED"
        default: return "Code(\(code))"
        }
    }

    /// Maps `Move operation returned error: N` → `axxonsoft.bl.ptz.EErrorCode` label when N is known.
    private static func prettifyTelemetryMessage(_ message: String) -> String {
        let prefix = "Move operation returned error:"
        guard message.hasPrefix(prefix) else { return message }
        let raw = message.dropFirst(prefix.count).trimmingCharacters(in: .whitespaces)
        guard let code = Int(raw) else { return message }
        switch code {
        case 0: return "PTZ move succeeded."
        case 1: return "PTZ session unavailable."
        case 2: return "PTZ move failed (general error)."
        case 3: return "PTZ preset error."
        case 4: return "PTZ command is not supported."
        default: return message
        }
    }
}
