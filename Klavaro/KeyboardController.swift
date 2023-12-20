//
//  KeyboardController.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit

class KeyboardController: KeyboardInputViewController {
    
    var diacriticState: DiacriticState = .disabled {
        didSet {
            print("hi")
        }
    }
    
    override func viewDidLoad() {
        services.layoutProvider = LayoutProvider(alphabeticInputSet: .esperanto(withDiacritics: false), numericInputSet: .standardNumeric(currency: "$"), symbolicInputSet: .standardSymbolic(currencies: ["$"]))
        services.styleProvider = StyleProvider(keyboardContext: state.keyboardContext)
        services.actionHandler = ActionHandler(controller: self)
        diacriticState = .enabled
    }
    
    override func insertText(_ text: String) {
        switch diacriticState {
        case .enabled:
            super.insertText(text.asDiacriticalEquivalent())
        default:
            super.insertText(text)
        }
    }
    
    func toggleDiacritics() {
        
    }
    
}
