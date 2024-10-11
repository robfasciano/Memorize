//
//  EmojiMemoryGame.swift
//  Memorize
//  is a ViewModel
//  is the View's butler
//
//  Created by Robert Fasciano on 10/11/24.
//

import SwiftUI

func createCardContent(forPairAtIndex index: Int) -> String {
     ["👻", "🎃", "👹", "👽","💀", "🤡", "👺", "🧙🏼","🙀", "😱", "☠️", "🕸️"][index]
}

class EmojiMemoryGame {
    private var model = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: )
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
