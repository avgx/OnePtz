import Foundation
import Testing
import OnePtz

@Suite("Position decoding")
struct PositionDecodingTests {
    @Test("decode GetPositionInformationResponse")
    func decode_position() throws {
        let json = """
        {
          "absolute_position": {"pan": 10, "tilt": 20, "zoom": 30, "mask": 7},
          "error_code": "NotError"
        }
        """
        let value = try JSONDecoder().decode(GetPositionInformationResponse.self, from: Data(json.utf8))
        #expect(value.absolutePosition?.pan == 10)
        #expect(value.errorCode?.value == .notError)
    }
}
