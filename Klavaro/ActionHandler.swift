//
//  ActionHandler.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-19.
//

import KeyboardKit

class ActionHandler: StandardKeyboardActionHandler {
    
    override func action(for gesture: Gestures.KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        let standard = super.action(for: gesture, on: action)
        if action == Constants.Actions.toggleDiacritics && gesture == .release {
            guard let controller = keyboardController as? KeyboardController else { return nil }
            controller.insertText(" [\(gesture.rawValue)] ")
            return nil
        }
        
        return standard
    }
    
}
