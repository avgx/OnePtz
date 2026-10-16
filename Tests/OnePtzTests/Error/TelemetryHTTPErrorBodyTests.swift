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

    @Test("route missing is grpc 12 or bare 404/501")
    func routeMissing() {
        let unimplemented = Data(#"{"grpcErrorCode":12}"#.utf8)
        let notFound = Data(#"{"grpcErrorCode":5,"errorMessage":"no camera"}"#.utf8)
        #expect(TelemetryHTTPErrorBody.isNativeRouteMissing(body: unimplemented, statusCode: 404))
        #expect(!TelemetryHTTPErrorBody.isNativeRouteMissing(body: notFound, statusCode: 404))
        #expect(TelemetryHTTPErrorBody.isNativeRouteMissing(body: Data("<html>".utf8), statusCode: 404))
        #expect(TelemetryHTTPErrorBody.isNativeRouteMissing(body: Data(), statusCode: 501))
        #expect(!TelemetryHTTPErrorBody.isNativeRouteMissing(body: Data(), statusCode: 500))
    }
}
