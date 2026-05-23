import Foundation
import Testing
import OnePtz

@Suite("Session decoding")
struct SessionDecodingTests {
    @Test("decode AcquireSessionResponse")
    func decode_acquireSession() throws {
        let json = """
        {
          "session_id": 7,
          "error_code": "NotError",
          "expiration_time": "20260101T120000.000000",
          "session_info": {
            "subject_name": "root",
            "host_name": "client-1"
          }
        }
        """
        let value = try JSONDecoder().decode(AcquireSessionResponse.self, from: Data(json.utf8))
        #expect(value.sessionId == 7)
        #expect(value.errorCode?.value == .notError)
        #expect(value.sessionInfo?.subjectName == "root")
    }

    @Test("decode KeepAliveResponse")
    func decode_keepAlive() throws {
        let json = """
        {"result": true, "expiration_time": "20260101T120000.000000"}
        """
        let value = try JSONDecoder().decode(KeepAliveResponse.self, from: Data(json.utf8))
        #expect(value.result == true)
    }
}
