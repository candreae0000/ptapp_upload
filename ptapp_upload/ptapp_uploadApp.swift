//
//  ptapp_uploadApp.swift
//  ptapp_upload
//
//  Created by Cecilia Andreae on 11/12/23.
//

import SwiftUI

@main
struct ptapp_uploadApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
