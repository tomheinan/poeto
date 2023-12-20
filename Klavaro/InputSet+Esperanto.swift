//
//  EsperantoInputSet.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit

extension InputSet {
    
    static func esperanto(withDiacritics: Bool) -> InputSet {
        .init(rows: [
            .init(chars: (withDiacritics ? "ertŭiop" : "ertuiop")),
            .init(chars: (withDiacritics ? "aŝdfĝĥĵkl" : "asdfghjkl")),
            .init(phone: (withDiacritics ? "zĉvbnm" : "zcvbnm"), pad: (withDiacritics ? "zĉvbnm,." : "zcvbnm,."))
        ])
    }
}
