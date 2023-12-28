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
        static let sharedFolderURL: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)!
        static let sharedUserDefaults: UserDefaults = UserDefaults(suiteName: appGroupIdentifier)!
    }
    
    struct Colors {
        static let primaryGreen = Color("primaryGreen", bundle: nil)
        static let secondaryGreen = Color("secondaryGreen", bundle: nil)
        static let diacriticHint = Color("diacriticHint", bundle: nil)
    }
    
    struct Images {
        static let star = Image("star", bundle: nil).resizable()
        static let starSelected = Image("starSelected", bundle: nil).resizable()
    }
    
}
