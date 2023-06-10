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
            TimerView(timeRemaining: 210, isStart: true)
            Divider()
            AnswerView(strAnswer: "애플")
            
            Divider()
            ZStack {
                CanvasView(canvas: canvas)
            }
            .background(.black)
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
