//
//  KeyboardController.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit
import SwiftUI

class KeyboardController: KeyboardInputViewController {
    
    //@State var enableDiacritics = false
    var diacritics = Diacritics()
    
    override func viewDidLoad() {
        services.layoutProvider = LayoutProvider(alphabeticInputSet: .esperanto, numericInputSet: .standardNumeric(currency: "$"), symbolicInputSet: .standardSymbolic(currencies: ["$"]))
        services.styleProvider = StyleProvider(keyboardContext: state.keyboardContext, diacritics: diacritics)
        services.actionHandler = ActionHandler(controller: self)
        services.calloutActionProvider = StandardCalloutActionProvider(keyboardContext: state.keyboardContext, baseProvider: CalloutActionProvider())
    }
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { params in
                    switch params.item.action {
                    case .character(let character):
                        if character != character.asDiacriticalEquivalent() {
                            KeyboardButton.CustomContent(action: params.item.action, styleProvider: self.services.styleProvider, keyboardContext: self.state.keyboardContext, diacritics: self.diacritics)
                        } else {
                            params.view
                        }
                    default:
                        params.view
                    }
                },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
        }
    }
    
    override func insertText(_ text: String) {
        if diacritics.enabled {
            super.insertText(text.asDiacriticalEquivalent())
            diacritics.enabled = false
        } else {
            super.insertText(text)
        }
    }
    
    func toggleDiacritics() {
        diacritics.enabled.toggle()
    }
    
}
