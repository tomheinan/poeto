//
//  String+EsperantoDiacritics.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-19.
//

import Foundation

extension String {
    
    func asDiacriticalEquivalent() -> String {
        switch self {
        case "c":
            return "ĉ"
        case "g":
            return "ĝ"
        case "h":
            return "ĥ"
        case "j":
            return "ĵ"
        case "s":
            return "ŝ"
        case "u":
            return "ŭ"
        case "C":
            return "Ĉ"
        case "G":
            return "Ĝ"
        case "H":
            return "Ĥ"
        case "J":
            return "Ĵ"
        case "S":
            return "Ŝ"
        case "U":
            return "Ŭ"
        default:
            return self
        }
    }
    
}
