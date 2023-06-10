//
//  SukGiSiDaeApp.swift
//  SukGiSiDae
//
//  Created by ChangMin on 2023/06/10.
//

import SwiftUI

@main
struct SukGiSiDaeApp: App {
    var repository = GameRepository()

    var body: some Scene {
        WindowGroup {
            ContentView(gameListQuery: repository.gameListQuery)
                .onAppear {
                    repository.initializeGames()
                }
        }
        .modelContainer(Database.shared.container)
    }
}
