//
//  ISSWatchApp.swift
//  ISSWatch
//
//  Created by John Paul on 11/12/2024.
//

import SwiftUI

@main
struct ISSWatchApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
