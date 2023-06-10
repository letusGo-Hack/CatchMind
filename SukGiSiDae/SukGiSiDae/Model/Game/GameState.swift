//
//  GameState.swift
//  SukGiSiDae
//

import Foundation
import SwiftUI

class MyGameState: ObservableObject {
    @Published var gameState = GameState()
}

struct GameState: Codable {
    var status: GameStatus = .시작_대기
    var game: GameModel?
    var currentRound: Int
    var winner: User?
    var host: User?
    var player: [User]

    init() {
        self.status = .시작_대기
        self.game = nil
        self.currentRound = -1
        self.winner = nil
        self.host = nil
        self.player = []
    }
}

extension GameState {
    var quiz: Quiz? {
        game?.quizes[currentRound]
    }

    var maxRound: Int {
        game?.quizes.count ?? 0
    }

    var isFinalRound: Bool {
        maxRound == currentRound
    }
}
