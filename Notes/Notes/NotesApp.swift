//
//  NotesApp.swift
//  Notes
//
//  Created by Tommaso Barbiero on 07/12/21.
//

import SwiftUI

@main
struct NotesApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
