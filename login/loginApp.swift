//
//  loginApp.swift
//  login
//
//  Created by Apple Esprit on 14/3/2023.
//

import SwiftUI

@main
struct loginApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
           //zaza()
           // HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
