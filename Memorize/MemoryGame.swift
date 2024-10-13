//
//  MemorizeGame.swift
//  Memorize
//  is a Model (no UI)
//
//  Created by Robert Fasciano on 10/11/24.
//

import Foundation //ararys, Ints, Bools, etc

// adding Equateable makes CardContent become a "care a little bit" that entire model can access (i.e. defined once)
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>  //should tend towards everything being private (access control)
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numbeOfPairsOfCards x2
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a")) //to make cards equateable
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
  
    var indexOfTheOneAndOnyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    //because this needs to change model, mark function as mutable
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String { //needed to implement CustomDebugStringConvertible
            "\(id) \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " Matched" : "")"
        }
        
        
//not needed since made content Equatable, otherwise would be need to amke this Equatable
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp &&
//            lhs.isMatched == rhs.isMatched &&
//            lhs.content == rhs.content
//        }
        //placed indice MemoryGame struct for "name-spacing" nesting
        var isFaceUp = false
        var isMatched = false
        let content: CardContent

        var id: String //needed to make identifiable
    }
    
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
