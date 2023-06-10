//
//  GameRepository.swift
//  SukGiSiDae
//

import Foundation
import SwiftData
import SwiftUI

protocol GameRepositoryProtocol {
    func initializeGames()

    func fetchRandomGame() -> Game
}

final class GameRepository {
    private let database: Database = .shared

    @MainActor func initializeGames() {
        let games = createGames()
        games.forEach {
            database.mainContext.insert($0)
        }
    }

    var randomGame: Game {
        createGames().first!
    }

    var gameListQuery: Query<Game, [Game]> {
        let sortOrder: SortOrder = .forward

        return Query.init(sort: \.id, order: sortOrder)
    }
}

private extension GameRepository {
    func createGames() -> [Game] {
        let numberOfGames: Int = 10

        return (0..<numberOfGames).map { _ in
            let numberOfRounds: Int = 5
            let quizes: [String] = words
                .shuffled()
                .prefix(numberOfRounds)
                .map { String($0) }

            return .init(quizes: quizes)
        }
    }

    private var words: [String] {
        [
            "스님",
            "오븐",
            "연극",
            "우유",
            "포스터",
            "낙엽",
            "일기예보",
            "일식",
            "남극",
            "약",
            "새총",
            "야채",
            "축구",
            "법",
            "좀비",
            "거북이",
            "콩",
            "신발",
            "고구마",
            "생선",
            "반찬",
            "스님",
            "스님",
            "새싹",
            "학력",
            "실력자",
            "약봉지",
            "창공",
            "잡음",
            "창틀",
            "언급",
            "곤봉",
            "외국인",
            "고대",
            "정규",
            "헤드라이트",
            "동화",
            "세계",
            "탄광",
            "평상",
            "태풍",
            "아편",
            "강도",
            "필름"
        ]
    }
}
