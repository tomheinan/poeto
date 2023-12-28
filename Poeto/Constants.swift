//
//  Constants.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-28.
//

import Foundation

struct Constants {
    
    struct AppGroup {
        static let appGroupIdentifier = "group.app.poeto"
        static let sharedFolderURL: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)!
        static let sharedUserDefaults: UserDefaults = UserDefaults(suiteName: appGroupIdentifier)!
    }
    
}
