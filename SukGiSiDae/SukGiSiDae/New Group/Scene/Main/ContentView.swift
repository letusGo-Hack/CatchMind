//
//  ContentView.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var gameListQuery: [Game]
    @State var user: GameUser
    @StateObject var canvas = Canvas()
    var body: some View {
        VStack {
            TimerView(timeRemaining: user.timer, isStart: true)
            Divider()
//            if let game = gameListQuery.first {
            if user.isQuestioner {
                AnswerView(strAnswer: "\(user.strAnswer ?? "뭐지?")")
            }
//            }else {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//            }
            
            Divider()
            ZStack {
                CanvasView(canvas: canvas)
            }
            .background(.black)
        }.padding()
            .background(
                Image("stoneBackground")
            )
            .onAppear() {
                let game = GameRepository().randomGame
                getUser()
                print("quizs : \(user.strAnswer)")
            }
    }
    
    func getUser() {
        guard let game = gameListQuery.first else { return }
        user = GameUser(isQuestioner: true, strAnswer: game.quizes.first ?? "", timer: 180, successCnt: 1, gameCnt: 1)
    }
}

#Preview {
    ContentView(user: GameUser(isQuestioner: false, strAnswer: "", timer: 180, successCnt: 1, gameCnt: 1))
}
