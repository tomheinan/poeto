//
//  EsperantoInputSet.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit

extension InputSet {
    
    static var esperanto: InputSet {
        .init(rows: [
            .init(chars: "ertuiop"),
            .init(chars: "asdfghjkl"),
            .init(phone: "zcvbnm", pad: "zcvbnm,.")
        ])
    }
}
