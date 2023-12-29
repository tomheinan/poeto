//
//  String+IsCapitalized.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-28.
//

import Foundation

extension String {
    
    var isCapitalized: Bool {
        return self == self.capitalized
    }
    
}
