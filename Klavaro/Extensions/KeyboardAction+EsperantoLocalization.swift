//
//  KeyboardAction+EsperantoLocalization.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-27.
//

import KeyboardKit

public extension KeyboardAction {
    
    var esperantoLocalization: String? {
        switch self {
        case .primary(let returnKeyType): return returnKeyType.id
        case .space: return "spaco"
        default: return nil
        }
    }
    
}
