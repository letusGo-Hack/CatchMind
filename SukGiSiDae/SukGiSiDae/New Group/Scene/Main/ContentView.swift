//
//  ContentView.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var gameState: MyGameState
//    @Query var gameListQuery: [Game]
    @StateObject var canvas = Canvas() 
    @State private var inputtedAnswer: String = ""
    // "정답이에용" 대신에 실제 답 들어감
    private let answerArr: [String] = "정답이에옹".split(separator: "").map { String($0) }
    private let gameUseCase: GameUseCaseProtocol = GameUseCase(games: GameRepository().createGames())

    var body: some View {

        ZStack {
            Image("stoneBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            VStack {
                RefreshCanvasButton(canvas: canvas)

                TimerView(timeRemaining: 210, isStart: true)
                AnswerView(strAnswer: "애플")
                ZStack(alignment: .bottom) {
                    CanvasView(canvas: canvas)

                    HStack(spacing: 10) {
                        ForEach(answerArr, id: \.self) { _ in
                            InputtedAnswerView(inputtedAnswer: $inputtedAnswer)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))

                }
                .background(.black)

                AnswerInputTextField(inputtedAnswer: $inputtedAnswer)

            }
            .padding()
        }

        .task {
            for await session in GameActivity.sessions() {
                gameUseCase.configureGroupSession(session)
            }
        }
        .onAppear() {
            gameUseCase.startSession()
        }
    }
}
