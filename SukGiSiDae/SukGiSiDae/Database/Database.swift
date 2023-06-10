//
//  Database.swift
//  SukGiSiDae
//

import Foundation
import SwiftData

final class Database {
    static let shared: Database = .init()

    let container: ModelContainer = {
        let configuration = ModelConfiguration(inMemory: true, readOnly: true)

        var container = try! ModelContainer(for: [
            Game.self
        ])

        container.configurations.insert(configuration)

        return container
    }()

    @MainActor
    var mainContext: ModelContext {
        container.mainContext
    }
}
