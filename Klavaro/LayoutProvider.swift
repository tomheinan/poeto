//
//  LayoutProvider.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit
import SwiftUI

class LayoutProvider: InputSetBasedKeyboardLayoutProvider {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        layout.tryInsertLocaleSwitcher(for: context)
        layout.tryInsertDiacriticsButton()
        return layout
    }
    
}

private extension KeyboardLayout {
    
    func tryInsertLocaleSwitcher(for context: KeyboardContext) {
        guard context.hasMultipleLocales else { return }
        guard let button = tryCreateBottomRowItem(for:  .nextLocale) else { return }
        itemRows.insert(button, after: .space, atRow: bottomRowIndex)
    }
    
    func tryInsertDiacriticsButton() {
        var firstRow = itemRows[0]
        let thirdRow = itemRows[2]
        let nextKey = firstRow[0]
        guard let shiftKey = thirdRow.first else { return }
        
        let size = KeyboardLayout.ItemSize(width: shiftKey.size.width, height: nextKey.size.height)
        let diacriticsKey = KeyboardLayout.Item(action: Constants.Actions.toggleDiacritics, size: size, edgeInsets: shiftKey.edgeInsets)
        firstRow.insert(diacriticsKey, at: 0)
        itemRows[0] = firstRow
    }
    
}
