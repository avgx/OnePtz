import Foundation
import Testing
import OnePtz

@Suite("TelemetryHTTPErrorBody")
struct TelemetryHTTPErrorBodyTests {
    @Test("userFacingMessage prettifies move error codes")
    func userFacing() {
        let body = Data(#"{"errorMessage":"Move operation returned error: 1"}"#.utf8)
        #expect(TelemetryHTTPErrorBody.userFacingMessage(body: body) == "PTZ session unavailable.")
    }

    @Test("logDetail includes grpc name and status")
    func logDetail() {
        let body = Data(#"{"errorMessage":"missing","grpcErrorCode":12}"#.utf8)
        #expect(
            TelemetryHTTPErrorBody.logDetail(body: body, statusCode: 404)
                == "missing grpc=12 (UNIMPLEMENTED) http=404"
        )
    }

    @Test("route missing is grpc 12 or bare 403/404/501")
    func routeMissing() {
        let unimplemented = Data(#"{"grpcErrorCode":12}"#.utf8)
        let notFound = Data(#"{"grpcErrorCode":5,"errorMessage":"no camera"}"#.utf8)
        let denied = Data(#"{"grpcErrorCode":7,"errorMessage":"denied"}"#.utf8)
        #expect(TelemetryHTTPErrorBody.isNativeRouteMissing(body: unimplemented, statusCode: 404))
        #expect(!TelemetryHTTPErrorBody.isNativeRouteMissing(body: notFound, statusCode: 404))
        #expect(!TelemetryHTTPErrorBody.isNativeRouteMissing(body: denied, statusCode: 403))
        #expect(TelemetryHTTPErrorBody.isNativeRouteMissing(body: Data("<html>".utf8), statusCode: 404))
        #expect(TelemetryHTTPErrorBody.isNativeRouteMissing(body: Data(), statusCode: 403))
        #expect(TelemetryHTTPErrorBody.isNativeRouteMissing(body: Data(), statusCode: 501))
        #expect(!TelemetryHTTPErrorBody.isNativeRouteMissing(body: Data(), statusCode: 500))
    }

    @Test("servlet error_code is a separate enum from native EErrorCode")
    func servletErrorCode() {
        let body = Data(#"{"error_code":1}"#.utf8)
        #expect(LegacyTelemetryErrorCode.decode(body) == .general)
        #expect(TelemetryHTTPErrorBody.userFacingMessage(body: body) == LegacyTelemetryErrorCode.general.userMessage)
        #expect(LegacyTelemetryErrorCode.decode(Data(#"{"error_code":3}"#.utf8)) == .sessionUnavailable)
        #expect(LegacyTelemetryErrorCode.decode(Data(#"{"error_code":9}"#.utf8)) == nil)
    }
}
