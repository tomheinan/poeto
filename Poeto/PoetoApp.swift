//
//  PoetoApp.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-18.
//

import SwiftUI
import FirebaseCore

@main
struct PoetoApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                FirebaseApp.configure()
            }
        }
    }
    
    
}
