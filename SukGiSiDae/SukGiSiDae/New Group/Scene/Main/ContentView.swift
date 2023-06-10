//
//  ContentView.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI
import SwiftData

struct ContentView: View {
<<<<<<< HEAD:SukGiSiDae/SukGiSiDae/New Group/Scene/Main/ContentView.swift
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
=======
    @Query var gameListQuery: [Game]

    var body: some View {
        VStack {
            if let game = gameListQuery.first {
                Text("첫 번째 퀴즈 : \(game.quizes.first ?? "")")
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
        }
        .padding()
>>>>>>> main:SukGiSiDae/SukGiSiDae/Scene/Main/ContentView.swift
    }
}

#Preview {
    ContentView()
}
