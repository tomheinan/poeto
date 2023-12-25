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
        let firstRow = itemRows[0]
        let thirdRow = itemRows[2]
        guard let nextKey = firstRow.first else { return }
        guard let shiftKey = thirdRow.first else { return }
        
        let size = KeyboardLayout.ItemSize(width: shiftKey.size.width, height: nextKey.size.height)
        let toggleDiacriticsKey = KeyboardLayout.Item(action: Constants.Actions.toggleDiacritics, size: size, edgeInsets: shiftKey.edgeInsets)
        
        itemRows.insert(toggleDiacriticsKey, before: .character("e"), atRow: 0)
        itemRows.insert(KeyboardLayout.Item(action: .none, size: ItemSize(width: .available, height: 0)), before: .character("e"), atRow: 0)
        itemRows.insert(KeyboardLayout.Item(action: .none, size: ItemSize(width: .available, height: 0)), after: .character("p"), atRow: 0)
        
        itemRows.insert(toggleDiacriticsKey, before: .character("E"), atRow: 0)
        itemRows.insert(KeyboardLayout.Item(action: .none, size: ItemSize(width: .available, height: 0)), before: .character("E"), atRow: 0)
        itemRows.insert(KeyboardLayout.Item(action: .none, size: ItemSize(width: .available, height: 0)), after: .character("P"), atRow: 0)
    }
    
}
