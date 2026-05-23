# OnePtz

Swift package with **hand-written `Codable` models** and **typed HTTP request builders** for the Native BL **PTZ Telemetry** API (`v1/telemetry/*`), aligned with [`Telemetry.proto`](https://github.com/jerrygergov/axxon-telegram-vms/blob/main/support/protos/axxonsoft/bl/ptz/Telemetry.proto).

The package does **not** use protobuf code generation. Models follow the same conventions as [OneDomain](https://github.com/avgx/OneDomain).

**Platforms:** iOS 15+, macOS 13+, tvOS 17+, visionOS 1+  
**Swift tools:** 6.2+

## Dependencies

| Package | Role |
|---------|------|
| [RequestResponse](https://github.com/avgx/RequestResponse) | `TelemetryApi` returns `Request<T>` |
| [OneWireFormat](https://github.com/avgx/OneWireFormat) | `AccessPoint` typealias |
| [SafeEnum](https://github.com/avgx/SafeEnum) | Forward-compatible enum decoding |

## Relationship to OneDomain

- **OneDomain** — camera metadata: `Camera.ptzs[]` (`Telemetry`, capabilities, tag-and-track).
- **OnePtz** — runtime PTZ control: sessions, move/zoom/focus, presets, tours.

Typical flow:

```swift
import OneDomain
import OnePtz
import RequestResponse
import HTTP

let ptzAccessPoint = camera.ptzs?.first?.accessPoint
let session = try await http.send(
    TelemetryApi.acquireSession(AcquireSessionRequest(accessPoint: ptzAccessPoint, hostName: hostName)),
    with: builder
).value

try await http.send(
    TelemetryApi.move(MoveRequest(
        accessPoint: ptzAccessPoint,
        sessionId: session.sessionId,
        mode: Capabilities(isContinuous: true),
        valPan: 0.5,
        valTilt: 0
    )),
    with: builder
)
```

## Module layout

```
Sources/OnePtz/
├── API/           TelemetryApi
├── Capabilities/  Capabilities (TelemetryHelper.proto)
├── Session/       AcquireSession, KeepAlive, …
├── Move/          MoveRequest, CommonRequest, PointMove, AreaZoom
├── Position/      AbsolutePosition, GetPositionInformation
├── Preset/        Presets CRUD
├── Tour/          Tours list/play/fill
├── Auxiliary/     Auxiliary operations
├── Primitive/     Point, Rectangle
└── Error/         TelemetryErrorCode
```

## Tests

```bash
swift test
```

Tests cover API request builders and JSON decoding with inline fixtures. Capture real server responses into `Tests/OnePtzTests/Resources/` when validating against a demo server.

### Request vs response types

| Role | Protocol | `public init` |
|------|----------|---------------|
| `*Request` (POST body) | `Encodable` | yes |
| `*Request` (GET query only) | none — plain `Equatable` struct | yes |
| `*Response`, nested response DTOs | `Decodable` | no |
| Shared wire values (`AbsolutePosition`, …) | `Codable` | yes (client builds requests) |
| Request-only nested (`Capabilities`, `Point`, `Rectangle`, `Preset`) | `Encodable` | yes |

GET query requests are mapped to URL query in `TelemetryApi`, not JSON-encoded (same pattern as `HistoryRequest` in OneArchive).

### Integration tests

Live-server tests live in `Tests/OnePtzIntegrationTests/`. They are **skipped** unless `ONEPTZ_TEST_INTEGRATION=1` and `ONEPTZ_TEST_PASSWORD` are set (see [`.env.example`](.env.example)).

```bash
ONEPTZ_TEST_INTEGRATION=1 \
ONEPTZ_TEST_HOST=192.168.1.41 \
ONEPTZ_TEST_USER=root \
ONEPTZ_TEST_PASSWORD='…' \
ONEPTZ_TEST_TELEMETRY_ACCESS_POINT='hosts/…/TelemetryControl.0' \
swift test --filter PtzSessionIntegrationTests
```

If `ONEPTZ_TEST_TELEMETRY_ACCESS_POINT` is omitted, the test discovers the first enabled PTZ via `DomainApi.cameras(view: .VIEW_MODE_FULL)`.

Flow: **acquire session** → **continuous pan** → **stop** → **release session**.

Do not run integration tests in CI unless a PTZ-capable server is available.
