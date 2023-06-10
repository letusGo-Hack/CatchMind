//
//  User.swift
//  SukGiSiDae
//

import Foundation

struct User {
    let role: Role
    let win: Int
}

enum Role {
    case host // 첫 세션을 생성한 사람
    case player
}
