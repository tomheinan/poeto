//
//  StyleProvider.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-19.
//

import KeyboardKit
import Foundation

class StyleProvider: StandardKeyboardStyleProvider {
    
    override func buttonFontSize(for action: KeyboardAction) -> CGFloat {
        let standard = super.buttonFontSize(for: action)
        return action.isDiacritics ? 1.8 * standard : standard
    }
    
    override func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> KeyboardStyle.Button {
        if action.isDiacritics {
            return super.buttonStyle(for: .backspace, isPressed: isPressed)
        }
        return super.buttonStyle(for: action, isPressed: isPressed)
    }
    
    // override func buttonImage(for action: KeyboardAction) -> Image? {
    //     if action == .keyboardType(.emojis) { return nil }
    //     return super.buttonImage(for: action)
    // }

    // override func buttonText(for action: KeyboardAction) -> String? {
    //     if action == .return { return "⏎" }
    //     if action == .space { return "" }
    //     if action == .keyboardType(.emojis) { return "🤯" }
    //     return super.buttonText(for: action)
    // }

    // override var actionCalloutStyle: ActionCalloutStyle {
    //     var style = super.actionCalloutStyle()
    //     style.callout.backgroundColor = .red
    //     return style
    // }

    // override var inputCalloutStyle: InputCalloutStyle {
    //     var style = super.inputCalloutStyle()
    //     style.callout.backgroundColor = .blue
    //     style.callout.textColor = .yellow
    //     return style
    // }
}

private extension KeyboardAction {
    
    var isDiacritics: Bool {
        switch self {
        case .character(let char): return char == "✭"
        default: return false
        }
    }
}
