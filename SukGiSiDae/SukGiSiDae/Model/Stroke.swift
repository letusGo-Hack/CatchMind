/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A model that represents individual strokes.
*/

import Foundation
import SwiftUI

class Stroke: ObservableObject, Identifiable, Codable {
    let id: UUID
    @Published var points = [CGPoint]()
    let color: Color

    init(id: UUID = UUID(), color: Color) {
        self.id = id
        self.color = color
    }

    var path: Path {
        var path = Path()

        guard let start = points.first else { return path }
        path.move(to: start)
        for point in points.dropFirst() {
            path.addLine(to: point)
        }

        return path
    }

    // MARK: Codable

    enum CodingKeys: CodingKey {
        case id
        case points
        case color
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(points, forKey: .points)
        try container.encode(color, forKey: .color)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.points = try container.decode([CGPoint].self, forKey: .points)
        self.color = try container.decode(Color.self, forKey: .color)
    }
}

extension Stroke {
    enum Color: Int, Codable, CaseIterable {
        case black

        var uiColor: SwiftUI.Color {
            switch self {
            case .black:
                return .black
            }
        }
    }
}
