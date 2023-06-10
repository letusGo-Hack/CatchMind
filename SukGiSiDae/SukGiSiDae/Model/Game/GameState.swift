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
    var quiz: Quiz?
    var winner: User?
    var host: User?
    var player: [User]

    init() {
        self.status = .시작_대기
        self.quiz = nil
        self.winner = nil
        self.host = nil
        self.player = []
    }
}
