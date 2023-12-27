//
//  ReturnKeyType+EsperantoLocalization.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-27.
//

import KeyboardKit

extension Keyboard.ReturnKeyType {
    
    var esperantoLocalization: String {
        switch self {
        case .return: return "reveni"
        case .continue: return "daŭrigi"
        case .done: return "farite"
        case .emergencyCall: return "krisvoko"
        case .go: return "iri"
        case .join: return "aliĝi"
        case .newLine: return "linifino"
        case .next: return "sekva"
        case .ok: return "bone"
        case .route: return "enkursigi"
        case .search: return "serĉi"
        case .send: return "sendi"
        case .custom(title: let title): return title
        }
    }
    
}
