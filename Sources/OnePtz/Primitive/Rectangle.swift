import Foundation

/// Relative rectangle (`primitive.Rectangle`). Request body only.
public struct Rectangle: Encodable, Equatable, Sendable {
    public let x: Double
    public let y: Double
    public let w: Double
    public let h: Double
    public let index: Int?

    public init(x: Double, y: Double, w: Double, h: Double, index: Int? = nil) {
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.index = index
    }

    private enum CodingKeys: String, CodingKey {
        case x
        case y
        case w
        case h
        case index
    }
}
