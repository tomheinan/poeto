//
//  Diacritics.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-24.
//

import SwiftUI

@Observable class Diacritics {
    var enabled: Bool
    
    init(enabled: Bool = false) {
        self.enabled = enabled
    }
}
