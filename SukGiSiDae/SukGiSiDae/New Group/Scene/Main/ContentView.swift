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
    @State private var inputtedAnswer: String = ""
    // "정답이에용" 대신에 실제 답 들어감
    private let answerArr: [String] = "정답이에옹".split(separator: "").map { String($0) }
    private let gameUseCase = GameUseCase()
  
    var body: some View {
        VStack {
            BrushColorPicker()
            
            TimerView(timeRemaining: 210, isStart: true)
            Divider()
            AnswerView(strAnswer: "애플")
            
            Divider()
            ZStack {
                CanvasView(canvas: canvas)
                
                HStack(spacing: 10) {
                    ForEach(answerArr, id: \.self) { _ in
                        InputtedAnswerView(inputtedAnswer: $inputtedAnswer)
                    }
                }
            }
            .background(.black)
          
            AnswerInputTextField(inputtedAnswer: $inputtedAnswer)
            
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
