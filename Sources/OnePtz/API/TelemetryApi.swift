import Foundation
import OneWireFormat
import RequestResponse

/// PTZ Telemetry API (Native BL `v1/telemetry/*`).
///
/// Source: `Telemetry.proto` (`TelemetryService`).
public enum TelemetryApi {
    // MARK: - Sessions

    /// Endpoint: `GET /v1/telemetry/sessions`
    public static func acquireSession(_ parameters: AcquireSessionRequest) -> Request<AcquireSessionResponse> {
        Request(
            path: "v1/telemetry/sessions",
            method: .get,
            query: [
                ("access_point", parameters.accessPoint),
                ("host_name", parameters.hostName),
            ]
        )
    }

    /// Endpoint: `POST /v1/telemetry/sessions:keepAlive`
    public static func keepAlive(_ body: SessionRequest) -> Request<KeepAliveResponse> {
        Request(
            path: "v1/telemetry/sessions:keepAlive",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/sessions:release`
    public static func releaseSession(_ body: SessionRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry/sessions:release",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/sessions:checkAvailability`
    public static func isSessionAvailable(_ body: IsSessionAvailableRequest) -> Request<IsSessionAvailableResponse> {
        Request(
            path: "v1/telemetry/sessions:checkAvailability",
            method: .post,
            body: body
        )
    }

    // MARK: - Movement

    /// Endpoint: `POST /v1/telemetry:move`
    public static func move(_ body: MoveRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:move",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:zoom`
    public static func zoom(_ body: CommonRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:zoom",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:focus`
    public static func focus(_ body: CommonRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:focus",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:focusAuto`
    public static func focusAuto(_ body: SessionID) -> Request<Void> {
        Request(
            path: "v1/telemetry:focusAuto",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:iris`
    public static func iris(_ body: CommonRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:iris",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:irisAuto`
    public static func irisAuto(_ body: SessionID) -> Request<Void> {
        Request(
            path: "v1/telemetry:irisAuto",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:absoluteMove`
    public static func absoluteMove(_ body: AbsoluteMoveRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:absoluteMove",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:absoluteMoveN`
    ///
    /// Operates with normalized positions in range `{0;1}`.
    public static func absoluteMoveNormalized(_ body: AbsoluteMoveNormalizedRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:absoluteMoveN",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:pointMove`
    public static func pointMove(_ body: PointMoveRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:pointMove",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:areaZoom`
    public static func areaZoom(_ body: AreaZoomRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:areaZoom",
            method: .post,
            body: body
        )
    }

    // MARK: - Position

    /// Endpoint: `GET /v1/telemetry/position`
    public static func getPositionInformation(accessPoint: AccessPoint) -> Request<GetPositionInformationResponse> {
        Request(
            path: "v1/telemetry/position",
            method: .get,
            query: [
                ("access_point", accessPoint),
            ]
        )
    }

    /// Endpoint: `GET /v1/telemetry/position_n`
    ///
    /// Returns normalized positions in range `{0;1}`.
    public static func getPositionInformationNormalized(
        accessPoint: AccessPoint
    ) -> Request<GetPositionInformationNormalizedResponse> {
        Request(
            path: "v1/telemetry/position_n",
            method: .get,
            query: [
                ("access_point", accessPoint),
            ]
        )
    }

    // MARK: - Presets

    /// Endpoint: `GET /v1/telemetry/presets`
    public static func getPresetsInfo(accessPoint: AccessPoint) -> Request<PresetCollectionResponse> {
        Request(
            path: "v1/telemetry/presets",
            method: .get,
            query: [
                ("access_point", accessPoint),
            ]
        )
    }

    /// Endpoint: `POST /v1/telemetry/presets:set`
    public static func setPreset(_ body: SetPresetRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry/presets:set",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/presets:set2`
    public static func setPreset2(_ body: SetPresetRequest) -> Request<SetPresetResponse> {
        Request(
            path: "v1/telemetry/presets:set2",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry:configure`
    public static func configurePreset(_ body: ConfigurePresetRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry:configure",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/presets:go`
    public static func goPreset(_ body: GoPresetRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry/presets:go",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/presets:remove`
    public static func removePreset(_ body: RemovePresetRequest) -> Request<Void> {
        Request(
            path: "v1/telemetry/presets:remove",
            method: .post,
            body: body
        )
    }

    // MARK: - Auxiliary

    /// Endpoint: `GET /v1/telemetry/operations`
    public static func getAuxiliaryOperations(accessPoint: AccessPoint) -> Request<GetAuxiliaryOperationsResponse> {
        Request(
            path: "v1/telemetry/operations",
            method: .get,
            query: [
                ("access_point", accessPoint),
            ]
        )
    }

    /// Endpoint: `POST /v1/telemetry:performOperations`
    public static func performAuxiliaryOperation(
        _ body: PerformAuxiliaryOperationRequest
    ) -> Request<PerformAuxiliaryOperationResponse> {
        Request(
            path: "v1/telemetry:performOperations",
            method: .post,
            body: body
        )
    }

    // MARK: - Tours

    /// Endpoint: `GET /v1/telemetry/tours`
    public static func getTours(accessPoint: AccessPoint) -> Request<GetToursResponse> {
        Request(
            path: "v1/telemetry/tours",
            method: .get,
            query: [
                ("access_point", accessPoint),
            ]
        )
    }

    /// Endpoint: `GET /v1/telemetry/tours/points`
    public static func getTourPoints(accessPoint: AccessPoint, tourName: String) -> Request<GetTourPointsResponse> {
        Request(
            path: "v1/telemetry/tours/points",
            method: .get,
            query: [
                ("access_point", accessPoint),
                ("tour_name", tourName),
            ]
        )
    }

    /// Endpoint: `POST /v1/telemetry/tours:play`
    public static func playTour(_ body: PlayTourRequest) -> Request<PlayTourResponse> {
        Request(
            path: "v1/telemetry/tours:play",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/tours:stop`
    public static func stopTour(_ body: StopTourRequest) -> Request<StopTourResponse> {
        Request(
            path: "v1/telemetry/tours:stop",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/tours:startFill`
    public static func startFillTour(_ body: StartFillTourRequest) -> Request<StartFillTourResponse> {
        Request(
            path: "v1/telemetry/tours:startFill",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/tours:setPoint`
    public static func setTourPoint(_ body: SetTourPointRequest) -> Request<SetTourPointResponse> {
        Request(
            path: "v1/telemetry/tours:setPoint",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/tours:stopFill`
    public static func stopFillTour(_ body: StopFillTourRequest) -> Request<StopFillTourResponse> {
        Request(
            path: "v1/telemetry/tours:stopFill",
            method: .post,
            body: body
        )
    }

    /// Endpoint: `POST /v1/telemetry/tours:remove`
    public static func removeTour(_ body: RemoveTourRequest) -> Request<RemoveTourResponse> {
        Request(
            path: "v1/telemetry/tours:remove",
            method: .post,
            body: body
        )
    }
}
