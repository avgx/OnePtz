import Foundation
import Testing
import OnePtz

@Suite("Tour decoding")
struct TourDecodingTests {
    @Test("decode GetToursResponse")
    func decode_tours() throws {
        let json = """
        {
          "error_code": "NotError",
          "tours": [
            {"name": "Tour A", "state": "EIdle"},
            {"name": "Tour B", "state": "ETouring"}
          ]
        }
        """
        let value = try JSONDecoder().decode(GetToursResponse.self, from: Data(json.utf8))
        #expect(value.tours?.count == 2)
        #expect(value.tours?.first?.state?.value == .idle)
    }
}
