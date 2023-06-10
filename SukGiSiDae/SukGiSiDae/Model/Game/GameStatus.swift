//
//  GameStatus.swift
//  SukGiSiDae
//

import Foundation

enum GameStatus: Codable {
    case 시작_대기
    case 시작_카운트_다운
    case 게임_시작
    case 라운드_시작
    case 라운드_종료
    case 게임_종료
}
