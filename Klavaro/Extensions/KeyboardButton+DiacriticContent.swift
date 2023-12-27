//
//  KeyboardButton+CustomContent.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-24.
//

import KeyboardKit
import SwiftUI

extension KeyboardButton {

    struct DiacriticContent: View {

        public init(action: KeyboardAction, styleProvider: KeyboardStyleProvider) {
            self.action = action
            self.styleProvider = styleProvider
        }
        
        private let action: KeyboardAction
        private let styleProvider: KeyboardStyleProvider
        
        public var body: some View {
            bodyContent
                .padding(3)
                .contentShape(Rectangle())
        }
    }
}

private extension KeyboardButton.DiacriticContent {

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
            if let styleProvider = styleProvider as? StyleProvider, styleProvider.diacritics.enabled {
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

