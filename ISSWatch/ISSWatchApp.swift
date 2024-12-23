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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
