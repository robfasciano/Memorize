//
//  MemorizeGame.swift
//  Memorize
//  is a Model (no UI)
//
//  Created by Robert Fasciano on 10/11/24.
//

import Foundation //ararys, Ints, Bools, etc

struct MemoryGame<CardContent> {  //CardContent is a "don't care" that entire model can access (i.e. defined once)
    private(set) var cards: Array<Card>  //should tend towards everything being private (access control)
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numbeOfPairsOfCards x2
        for _ in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(card: Card) {
        
    }
    
    struct Card { //placed indice MemoryGame struct for "name-spacing" nesting
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
    
}
