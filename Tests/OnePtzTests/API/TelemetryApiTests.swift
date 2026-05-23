import Foundation
import RequestResponse
import Testing
import OnePtz

@Suite("TelemetryApi request builders")
struct TelemetryApiTests {
    private let accessPoint = "hosts/DemoServer/DeviceIpint.5/TelemetryControl.0"
    private let sessionId = 42

    @Test("acquireSession builds query parameters")
    func acquireSession_query() {
        let request = TelemetryApi.acquireSession(
            AcquireSessionRequest(accessPoint: accessPoint, hostName: "client-host")
        )
        #expect(request.path == "v1/telemetry/sessions")
        #expect(request.method == .get)
        #expect(request.query?.contains(where: { $0.0 == "access_point" && $0.1 == accessPoint }) == true)
        #expect(request.query?.contains(where: { $0.0 == "host_name" && $0.1 == "client-host" }) == true)
    }

    @Test("keepAlive posts session body")
    func keepAlive_body() {
        let body = SessionRequest(accessPoint: accessPoint, sessionId: sessionId)
        let request = TelemetryApi.keepAlive(body)
        #expect(request.path == "v1/telemetry/sessions:keepAlive")
        #expect(request.method == .post)
        #expect(request.body as? SessionRequest == body)
    }

    @Test("move posts move body")
    func move_body() {
        let body = MoveRequest(
            accessPoint: accessPoint,
            sessionId: sessionId,
            mode: Capabilities(isContinuous: true),
            valPan: 0.5,
            valTilt: -0.25
        )
        let request = TelemetryApi.move(body)
        #expect(request.path == "v1/telemetry:move")
        #expect(request.method == .post)
        #expect(request.body as? MoveRequest == body)
    }

    @Test("getPositionInformation builds query")
    func position_query() {
        let request = TelemetryApi.getPositionInformation(accessPoint: accessPoint)
        #expect(request.path == "v1/telemetry/position")
        #expect(request.method == .get)
        #expect(request.query?.contains(where: { $0.0 == "access_point" && $0.1 == accessPoint }) == true)
    }

    @Test("getTourPoints includes tour_name")
    func tourPoints_query() {
        let request = TelemetryApi.getTourPoints(accessPoint: accessPoint, tourName: "Tour-1")
        #expect(request.path == "v1/telemetry/tours/points")
        #expect(request.query?.contains(where: { $0.0 == "tour_name" && $0.1 == "Tour-1" }) == true)
    }

    @Test("typed Request response markers")
    func typed_request_markers() {
        let session = SessionRequest(accessPoint: accessPoint, sessionId: sessionId)

        let _: Request<AcquireSessionResponse> = TelemetryApi.acquireSession(
            AcquireSessionRequest(accessPoint: accessPoint, hostName: "host")
        )
        let _: Request<KeepAliveResponse> = TelemetryApi.keepAlive(session)
        let _: Request<Void> = TelemetryApi.releaseSession(session)
        let _: Request<GetPositionInformationResponse> = TelemetryApi.getPositionInformation(accessPoint: accessPoint)
        let _: Request<PresetCollectionResponse> = TelemetryApi.getPresetsInfo(accessPoint: accessPoint)
        let _: Request<GetToursResponse> = TelemetryApi.getTours(accessPoint: accessPoint)
    }
}
