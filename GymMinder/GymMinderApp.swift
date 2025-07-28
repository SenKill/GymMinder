//
//  GymMinderApp.swift
//  GymMinder
//
//  Created by Serik Musaev on 07.02.2025.
//

import SwiftUI

@main
struct GymMinderApp: App {
    
    init() {
        if !UserDefaults.standard.hasLaunchedBefore {
            CoreDataStack.shared.preloadDefaultData()
            UserDefaults.standard.hasLaunchedBefore = true
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
