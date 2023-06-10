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
    let answerArr: [String] = "정답이에옹".split(separator: "").map { String($0) }
    
    var body: some View {
        //        if let game = gameListQuery.first {
        //            Text("첫 번째 퀴즈 : \(game.quizes.first ?? "")")
        //        } else {
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundStyle(.tint)
        //            Text("Hello, world!")
        //        }
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
            
        }.padding()
            .onAppear() {
                let game = GameRepository().randomGame
                print("quizs : \(game.quizes)")
            }
        
    }
}
    
    #Preview {
        ContentView()
    }
