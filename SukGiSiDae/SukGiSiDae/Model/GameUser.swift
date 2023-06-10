//
//  GameUser.swift
//  SukGiSiDae
//
//  Created by kk on 6/10/23.
//

import Foundation
import SwiftUI

struct GameUser: Codable { 
    let isQuestioner: Bool // 질문자인지
    let strAnswer: String // 답
    let timer: Int
    let successCnt: Int // 몇개 맞았는지
    let gameCnt: Int // 몇개임 했는지
    
//    init() {
//        self.isQuestioner = false
//        self.strAnswer = ""
//        self.timer = 180
//        self.successCnt = 0
//        self.gameCnt = 0
//    }
//    () {
//        self.isQuestioner = false
//        self.strAnswer = ""
//        self.timer = 180
//        self.successCnt = 0
//        self.gameCnt = 0
//    }
}
