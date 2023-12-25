//
//  KeyboardButton+CustomContent.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-24.
//

import KeyboardKit
import SwiftUI

extension KeyboardButton {

    struct CustomContent: View {

        public init(action: KeyboardAction, styleProvider: KeyboardStyleProvider, keyboardContext: KeyboardContext, diacritics: Diacritics) {
            self.action = action
            self.styleProvider = styleProvider
            self.keyboardContext = keyboardContext
            self.diacritics = diacritics
        }
        
        private let action: KeyboardAction
        private let styleProvider: KeyboardStyleProvider
        private let keyboardContext: KeyboardContext
        var diacritics: Diacritics
        
        public var body: some View {
            bodyContent
                .padding(3)
                .contentShape(Rectangle())
        }
    }
}

private extension KeyboardButton.CustomContent {

    @ViewBuilder
    var bodyContent: some View {
        if let text = styleProvider.buttonText(for: action) {
            textView(for: action, text: text)
        } else {
            Text("")
        }
    }
    
    func textView(for action: KeyboardAction, text: String) -> some View {
        ZStack {
            if diacritics.enabled {
                KeyboardButton.Title(
                    text: text.asDiacriticalEquivalent(),
                    action: action
                )
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, styleProvider.buttonContentBottomMargin(for: action))
                    .foregroundStyle(Constants.Colors.primaryGreen)
                KeyboardButton.Title(
                    text: text,
                    action: action
                )
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, styleProvider.buttonContentBottomMargin(for: action))
                    .foregroundStyle(Constants.Colors.primaryGreen)
            } else {
                KeyboardButton.Title(
                    text: text.asDiacriticalEquivalent(),
                    action: action
                )
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, styleProvider.buttonContentBottomMargin(for: action))
                    .foregroundStyle(Constants.Colors.diacriticHint)
                KeyboardButton.Title(
                    text: text,
                    action: action
                )
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, styleProvider.buttonContentBottomMargin(for: action))
            }
        }
    }
}

