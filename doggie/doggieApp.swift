//
//  doggieApp.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI

@main
struct doggieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        // First WindowGroup for HomeView
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
        // Second WindowGroup for PetFamilyView
        WindowGroup {
            PetFamilyView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
        // Third WindowGroup for PetEditView
        WindowGroup {
            PetEditView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
