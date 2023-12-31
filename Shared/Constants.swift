//
//  KeyboardAction+ToggleDiacritics.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-19.
//

import KeyboardKit
import SwiftUI

struct Constants {
    
    struct Actions {
        static let toggleDiacritics = KeyboardAction.custom(named: "toggleDiacritics")
    }
    
    struct AppGroup {
        static let appGroupIdentifier = "group.app.poeto"
        static let sharedFolderURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)!
        static let sharedDBPath = Constants.AppGroup.sharedFolderURL.appending(path: Lexicon.databaseFilename).standardizedFileURL.path
        static let sharedUserDefaults = UserDefaults(suiteName: appGroupIdentifier)!
    }
    
    struct Colors {
        static let primaryGreen = Color("primaryGreen", bundle: nil)
        static let secondaryGreen = Color("secondaryGreen", bundle: nil)
        static let backgroundGreen = Color("backgroundGreen", bundle: nil)
        static let accentColor = Color("accentColor", bundle: nil)
        static let bodyText = Color("bodyText", bundle: nil)
        static let diacriticHint = Color("diacriticHint", bundle: nil)
    }
    
    struct Images {
        static let star = Image("star", bundle: nil).resizable()
        static let starSelected = Image("starSelected", bundle: nil).resizable()
    }
    
    struct Preferences {
        static let showHintsKey = "showHints"
    }
    
}
