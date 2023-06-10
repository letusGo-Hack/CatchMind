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
    @StateObject var canvas = Canvas()
    private let gameUseCase = GameUseCase()

    var body: some View {
        VStack {
            TimerView(timeRemaining: 210, isStart: true)
            Divider()
            AnswerView(strAnswer: "애플")
            
            Divider()
            ZStack {
                CanvasView(canvas: canvas)
            }
            .background(.black)
        }
        .padding()
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
    
    #Preview {
        ContentView()
    }
