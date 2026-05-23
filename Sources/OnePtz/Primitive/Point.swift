import Foundation

/// Relative point (`primitive.Point`). Request body only.
public struct Point: Encodable, Equatable, Sendable {
    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    private enum CodingKeys: String, CodingKey {
        case x
        case y
    }
}
