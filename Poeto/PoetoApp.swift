//
//  PoetoApp.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-18.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics

@main
struct PoetoApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        FirebaseApp.configure()
        setUpLexicon()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                
            }
        }
    }
    
    private func setUpLexicon() {
        Lexicon.setup()
        
        if let appVersion = Bundle.main.releaseVersionNumber {
            let wordCount = Lexicon.wordCount()
            print("Loaded Esperanto Lexicon v\(appVersion) (\(wordCount) words)")
            Analytics.logEvent("set_up_lexicon", parameters: ["version": appVersion, "word_count": wordCount])
        }
    }
}
