//
//  CalloutActionProvider.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-25.
//

import KeyboardKit
import UIKit

/**
 This demo-specific callout action provider adds a couple of
 dummy callouts when typing.
 */
class CalloutActionProvider: BaseCalloutActionProvider {
    
    override func calloutActionString(for char: String) -> String {
        switch char {
        case "c", "g", "h", "j", "s", "u", "C", "G", "H", "J", "S", "U":
            return [char, char.asDiacriticalEquivalent()].joined()
        default:
            return ""
        }
    }
}
