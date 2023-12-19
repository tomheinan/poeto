//
//  KeyboardController.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit

class KeyboardController: KeyboardInputViewController {
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
        }
    }
    
}
