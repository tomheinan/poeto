//
//  AutocompleteProvider.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-25.
//

import Foundation
import KeyboardKit

class EsperantoAutocompleteProvider: AutocompleteProvider {

    init(context: AutocompleteContext) {
        self.context = context
    }

    private var context: AutocompleteContext
    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
    
    func autocompleteSuggestions(for text: String) async throws -> [Autocomplete.Suggestion] {
        guard text.count > 0 else { return [] }
        return suggestions(for: text)
            .map {
                var suggestion = $0
                suggestion.isAutocorrect = $0.isAutocorrect && context.isAutocorrectEnabled
                return suggestion
            }
    }
}

private extension EsperantoAutocompleteProvider {
    
    func suggestions(for text: String) -> [Autocomplete.Suggestion] {
        let inputWord = Lexicon.Item(word: text)
        var suggestions: [Autocomplete.Suggestion] = []
        var candidateItems = Lexicon.search(word: text)
        
        if candidateItems.contains(inputWord) {
            if let candidateWord = candidateItems.first(where: { $0 == inputWord }) {
                suggestions.append(.init(text: candidateWord.word, isUnknown: false, subtitle: candidateWord.hintEnglish))
            }
            candidateItems.removeAll { $0 == inputWord }
        } else {
            suggestions.append(.init(text: inputWord.word, isUnknown: true))
        }
        
        var remainingWords = 2
        for candidateItem in candidateItems {
            suggestions.append(.init(text: candidateItem.word, subtitle: candidateItem.hintEnglish))
            remainingWords -= 1
            if remainingWords <= 0 {
                break
            }
        }
        
        return suggestions
    }
}
