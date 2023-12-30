//
//  Bundle+VersionInfo.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-29.
//

import Foundation

extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
