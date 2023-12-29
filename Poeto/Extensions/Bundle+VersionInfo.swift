//
//  Bundle+VersionInfo.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-29.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
