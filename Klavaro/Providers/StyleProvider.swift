//
//  StyleProvider.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-19.
//

import KeyboardKit
import Foundation
import SwiftUI

class StyleProvider: StandardKeyboardStyleProvider {
    
    var diacritics: Diacritics
    
    init(keyboardContext: KeyboardContext, diacritics: Diacritics) {
        self.diacritics = diacritics
        super.init(keyboardContext: keyboardContext)
    }
    
    override func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        switch isPressed {
        case false:
            switch action {
            case Constants.Actions.toggleDiacritics:
                if diacritics.enabled {
                    return Constants.Colors.primaryGreen
                } else {
                    return super.buttonBackgroundColor(for: .backspace, isPressed: isPressed)
                }
            case .character(let character):
                if character != character.asDiacriticalEquivalent() {
                    if diacritics.enabled {
                        return Constants.Colors.secondaryGreen
                    }
                }
                return super.buttonBackgroundColor(for: action, isPressed: isPressed)
            default:
                return super.buttonBackgroundColor(for: action, isPressed: isPressed)
            }
        case true:
            switch action {
            case Constants.Actions.toggleDiacritics:
                return super.buttonBackgroundColor(for: .backspace, isPressed: isPressed)
            default:
                return super.buttonBackgroundColor(for: action, isPressed: isPressed)
            }
        }
    }
    
     override func buttonImage(for action: KeyboardAction) -> Image? {
         if action == Constants.Actions.toggleDiacritics {
             if diacritics.enabled {
                 return Constants.Images.starSelected
             } else {
                 return Constants.Images.star
             }
         }
         
         return super.buttonImage(for: action)
     }
    
    override func buttonImageScaleFactor(for action: KeyboardAction) -> CGFloat {
        if action == Constants.Actions.toggleDiacritics {
            return 0.6
        }
        
        return super.buttonImageScaleFactor(for: action)
    }

}
