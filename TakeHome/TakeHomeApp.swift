//
//  TakeHomeApp.swift
//  TakeHome
//
//  Created by Duy Phuong on 19/09/2024.
//

import SwiftUI

@main
struct TakeHomeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
