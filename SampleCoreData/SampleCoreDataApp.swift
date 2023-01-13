//
//  SampleCoreDataApp.swift
//  SampleCoreData
//

//

import SwiftUI

@main
struct SampleCoreDataApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            Splash()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
