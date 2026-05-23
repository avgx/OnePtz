import Foundation
import Testing
import OnePtz

@Suite("Preset decoding")
struct PresetDecodingTests {
    @Test("decode PresetCollectionResponse")
    func decode_presets() throws {
        let json = """
        {
          "preset_info": [
            {
              "label": "Home",
              "position": 1,
              "name": "Preset 1",
              "saved_on_device": true,
              "absolute_pan": 100,
              "absolute_tilt": 200,
              "absolute_zoom": 50
            }
          ],
          "error_code": "NotError"
        }
        """
        let value = try JSONDecoder().decode(PresetCollectionResponse.self, from: Data(json.utf8))
        #expect(value.presetInfo?.count == 1)
        #expect(value.presetInfo?.first?.position == 1)
        #expect(value.errorCode?.value == .notError)
    }
}
