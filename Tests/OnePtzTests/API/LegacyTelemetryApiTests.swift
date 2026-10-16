import Foundation
import Testing
import OnePtz
import OneWireFormat

@Suite("LegacyTelemetryApi request builders")
struct LegacyTelemetryApiTests {
    private let accessPoint = "hosts/DemoServer/DeviceIpint.5/TelemetryControl.0"
    private let sessionId = 42

    @Test("acquireSession builds path and priority")
    func acquireSession_query() {
        let request = LegacyTelemetryApi.acquireSession(accessPoint: accessPoint)
        #expect(request.path == "control/telemetry/session/acquire/\(accessPoint.nohosts)")
        #expect(request.method == .get)
        #expect(request.query?.contains(where: { $0.0 == "session_priority" && $0.1 == "1" }) == true)
    }

    @Test("keepAlive and release carry session id")
    func session_query() {
        let keep = LegacyTelemetryApi.keepAlive(accessPoint: accessPoint, sessionId: sessionId)
        let release = LegacyTelemetryApi.releaseSession(accessPoint: accessPoint, sessionId: sessionId)
        #expect(keep.path == "control/telemetry/session/keepalive/\(accessPoint.nohosts)")
        #expect(release.path == "control/telemetry/session/release/\(accessPoint.nohosts)")
        #expect(keep.query?.contains(where: { $0.0 == "session_id" && $0.1 == "42" }) == true)
        #expect(release.method == .get)
    }

    @Test("move builds continuous query")
    func move_query() {
        let request = LegacyTelemetryApi.move(
            accessPoint: accessPoint,
            sessionId: sessionId,
            mode: .continuous,
            pan: 0.5,
            tilt: -0.25
        )
        #expect(request.path == "control/telemetry/move/\(accessPoint.nohosts)")
        #expect(request.query?.contains(where: { $0.0 == "mode" && $0.1 == "continuous" }) == true)
        #expect(request.query?.contains(where: { $0.0 == "pan" && $0.1 == "0.5" }) == true)
        #expect(request.query?.contains(where: { $0.0 == "tilt" && $0.1 == "-0.25" }) == true)
    }
}
