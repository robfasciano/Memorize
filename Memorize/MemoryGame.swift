//
//  MemorizeGame.swift
//  Memorize
//  is a Model (no UI)
//
//  Created by Robert Fasciano on 10/11/24.
//

import Foundation //ararys, Ints, Bools, etc

struct MemoryGame<CardContent> {  //CardContent is a "don't care" that entire model can access (i.e. defined once)
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card { //placed indice MemoryGame struct for "name-spacing" nesting
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
    
}
