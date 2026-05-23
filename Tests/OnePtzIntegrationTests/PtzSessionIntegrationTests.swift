import Foundation
import HTTP
import OnePtz
import Testing

@Suite("PTZ session integration", .tags(.integration))
struct PtzSessionIntegrationTests {
    @Test("acquire session, move camera, release session")
    func acquire_move_release() async throws {
        guard let context = PtzIntegration.context else { return }

        guard let telemetryAccessPoint = try await PtzIntegration.resolveTelemetryAccessPoint(using: context) else {
            Issue.record("No PTZ access point: set ONEPTZ_TEST_TELEMETRY_ACCESS_POINT or use a server with cameras that expose ptzs[]")
            return
        }

        let acquire = try await context.client.send(
            TelemetryApi.acquireSession(
                AcquireSessionRequest(
                    accessPoint: telemetryAccessPoint,
                    hostName: PtzIntegration.hostName
                )
            ),
            with: context.builder
        )

        #expect(acquire.value.sessionId > 0)
        if let errorCode = acquire.value.errorCode?.value {
            #expect(errorCode == .notError)
        }

        let sessionId = acquire.value.sessionId
        let continuous = Capabilities(isContinuous: true)

        try await context.client.send(
            TelemetryApi.move(
                MoveRequest(
                    accessPoint: telemetryAccessPoint,
                    sessionId: sessionId,
                    mode: continuous,
                    valPan: 0.3,
                    valTilt: 0
                )
            ),
            with: context.builder
        )

        try await Task.sleep(nanoseconds: NSEC_PER_SEC / 2)

        try await context.client.send(
            TelemetryApi.move(
                MoveRequest(
                    accessPoint: telemetryAccessPoint,
                    sessionId: sessionId,
                    mode: continuous,
                    valPan: 0,
                    valTilt: 0
                )
            ),
            with: context.builder
        )

        try await context.client.send(
            TelemetryApi.releaseSession(
                SessionRequest(
                    accessPoint: telemetryAccessPoint,
                    sessionId: sessionId
                )
            ),
            with: context.builder
        )
    }
}
