//
//  SukGiSiDaeApp.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

@main
struct SukGiSiDaeApp: App {
    private var gameState = MyGameState()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(gameState)
            
            //            ContentView(gameListQuery: repository.gameListQuery)
            //                .onAppear {
            //                    repository.initializeGames()
            //                }
//            StartView(gameListQuery: repository.gameListQuery, tag: 0).onAppear {
//                repository.initializeGames()
//            }
        }
        .modelContainer(Database.shared.container)
    }
}
