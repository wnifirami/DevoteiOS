//
//  DevoteIosApp.swift
//  DevoteIos
//
//  Created by Rami Ounifi on 17/5/2021.
//

import SwiftUI

@main
struct DevoteIosApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme( isDarkMode ? .dark : .light)
        }
    }
}
