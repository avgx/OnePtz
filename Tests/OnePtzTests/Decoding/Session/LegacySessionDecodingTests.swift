import Foundation
import Testing
import OnePtz

@Suite("Legacy session decoding")
struct LegacySessionDecodingTests {
    @Test("decode LegacyAcquireSessionResponse")
    func decode_acquire() throws {
        let json = #"{"session_id": 7}"#
        let value = try JSONDecoder().decode(LegacyAcquireSessionResponse.self, from: Data(json.utf8))
        #expect(value.sessionId == 7)
    }
}
