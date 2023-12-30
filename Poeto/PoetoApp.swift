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
        setUpSettings()
        setUpPreferences()
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
        
        if let appVersion = Bundle.main.versionNumber {
            let wordCount = Lexicon.wordCount()
            print("Loaded Esperanto Lexicon v\(appVersion) (\(wordCount) words)")
            Analytics.logEvent("set_up_lexicon", parameters: ["version": appVersion, "word_count": wordCount])
        }
    }
    
    private func setUpSettings() {
        UserDefaults.standard.set(Bundle.main.versionNumber, forKey: "versionPref")
        UserDefaults.standard.set(Bundle.main.buildNumber, forKey: "buildPref")
    }
    
    private func setUpPreferences() {
        if Constants.AppGroup.sharedUserDefaults.value(forKey: Constants.Preferences.showHintsKey) == nil {
            Constants.AppGroup.sharedUserDefaults.set(true, forKey: Constants.Preferences.showHintsKey)
            Analytics.logEvent("set_preference", parameters: ["key":"show_hints", "value":true])
        }
    }
}
