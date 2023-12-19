//
//  ContentView.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = "provu la klavaron ĉi tie..."
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $text)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
                .navigationTitle("Poeto")
                .typesettingLanguage(Locale.Language(identifier: "eo"))
        }
    }
    
}

#Preview {
    ContentView()
}
