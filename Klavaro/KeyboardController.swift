//
//  KeyboardController.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit
import SwiftUI

class KeyboardController: KeyboardInputViewController {
    
    var diacritics = Diacritics()
    
    override func viewDidLoad() {
        services.actionHandler = ActionHandler(controller: self, keyboardContext: state.keyboardContext, keyboardBehavior: services.keyboardBehavior, autocompleteContext: state.autocompleteContext, feedbackConfiguration: state.feedbackConfiguration, spaceDragGestureHandler: services.spaceDragGestureHandler)
        services.autocompleteProvider = EsperantoAutocompleteProvider(context: state.autocompleteContext)
        services.calloutActionProvider = StandardCalloutActionProvider(keyboardContext: state.keyboardContext, baseProvider: CalloutActionProvider())
        services.layoutProvider = LayoutProvider(alphabeticInputSet: .esperanto, numericInputSet: .standardNumeric(currency: "$"), symbolicInputSet: .standardSymbolic(currencies: ["$"]))
        services.styleProvider = StyleProvider(keyboardContext: state.keyboardContext, diacritics: diacritics)
        
        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        let sp = services.styleProvider

        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { params in
                    switch params.item.action {
                    case .character(let character):
                        if character != character.asDiacriticalEquivalent() {
                            KeyboardButton.DiacriticContent(action: params.item.action, styleProvider: sp)
                        } else {
                            params.view
                        }
                    case Constants.Actions.toggleDiacritics:
                        KeyboardButton.DiacriticContent(action: params.item.action, styleProvider: sp)
                    case .space:
                        KeyboardButton.SpaceContent(localeText: "Esperanto", spaceView: KeyboardButton.Title(text: params.item.action.esperantoLocalization ?? "␣", action: .space))
                    case .primary(let returnKeyType):
                        KeyboardButton.Title(text: returnKeyType.esperantoLocalization, action: .primary(returnKeyType))
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
