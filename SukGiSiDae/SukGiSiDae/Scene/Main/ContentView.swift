//
//  ContentView.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            let game = GameRepository().randomGame
            print("quizs : \(game.quizes)")
        }
    }
}

#Preview {
    ContentView()
}
