//
//  Game.swift
//  SukGiSiDae
//

import Foundation
import SwiftData

@Model
class Game {
    let id: String
    let quizes: [String]

    init(quizes: [String]) {
        self.id = UUID().uuidString
        self.quizes = quizes
    }
}

struct GameModel: Codable {
    let quizes: [String]

    init(game: Game) {
        self.quizes = game.quizes
    }
}
