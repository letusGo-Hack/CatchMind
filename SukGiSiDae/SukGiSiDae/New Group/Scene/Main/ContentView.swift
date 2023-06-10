//
//  ContentView.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var canvas = Canvas()
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
