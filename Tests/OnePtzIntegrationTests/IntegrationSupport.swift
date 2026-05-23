import Foundation
import HTTP
import OneDomain
import RequestResponse

enum PtzIntegration {
    struct Context {
        let baseURL: URL
        let user: String
        let password: String
        let telemetryAccessPoint: String?
        let client: HTTPClient
        let builder: RequestBuilder
    }

    /// Active when `ONEPTZ_TEST_INTEGRATION=1` and `ONEPTZ_TEST_PASSWORD` is non-empty.
    static var context: Context? {
        guard TestEnvironment.value(for: "ONEPTZ_TEST_INTEGRATION") == "1" else { return nil }

        let scheme = TestEnvironment.value(for: "ONEPTZ_TEST_SCHEME") ?? "http"
        let host = TestEnvironment.value(for: "ONEPTZ_TEST_HOST") ?? "try.axxonsoft.com"
        let user = TestEnvironment.value(for: "ONEPTZ_TEST_USER") ?? "root"
        let password = TestEnvironment.value(for: "ONEPTZ_TEST_PASSWORD") ?? ""
        guard !password.isEmpty else { return nil }

        guard let baseURL = URL(string: "\(scheme)://\(host)") else { return nil }

        let authorization = Authorization.basic(.init(user: user, password: password))
        var headers: [String: String] = [:]
        if let authHeader = authorization.header {
            headers["Authorization"] = authHeader
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = headers
        let client = HTTPClient(configuration: configuration)
        let builder = RequestBuilder.json(
            baseURL: baseURL,
            encoder: JSONEncoder(),
            sessionDefaultHeaders: headers
        )

        return Context(
            baseURL: baseURL,
            user: user,
            password: password,
            telemetryAccessPoint: TestEnvironment.value(for: "ONEPTZ_TEST_TELEMETRY_ACCESS_POINT"),
            client: client,
            builder: builder
        )
    }

    static func resolveTelemetryAccessPoint(using context: Context) async throws -> String? {
        if let telemetryAccessPoint = context.telemetryAccessPoint {
            return telemetryAccessPoint
        }

        let pages = try await context.client.pages(
            DomainApi.cameras(view: .VIEW_MODE_FULL),
            with: context.builder
        )

        for camera in pages.flatMap(\.items) {
            if let telemetry = camera.ptzs?.first(where: \.enabled) {
                return telemetry.accessPoint
            }
        }

        return nil
    }

    static var hostName: String {
        ProcessInfo.processInfo.hostName
    }
}
