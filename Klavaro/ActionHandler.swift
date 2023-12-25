//
//  ActionHandler.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-19.
//

import KeyboardKit

class ActionHandler: StandardKeyboardActionHandler {
    
    override func handle(_ gesture: Gesture, on action: KeyboardAction) {
        super.handle(gesture, on: action)
        
        guard gesture == .release, let controller = keyboardController as? KeyboardController else { return }
        
        switch action {
        case Constants.Actions.toggleDiacritics:
            controller.toggleDiacritics()
        default:
            return
        }
        
    }
    
}
