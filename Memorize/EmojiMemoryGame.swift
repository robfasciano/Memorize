//
//  EmojiMemoryGame.swift
//  Memorize
//  is a ViewModel
//  is the View's butler
//
//  Created by Robert Fasciano on 10/11/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    //static will make this a Namespace global (also made private)- forced initialization before other class variables
    //this is really EmojiMemoryGame.emoji, but swift can infer this prefix
    private static let emojis = ["👻", "🎃", "👹", "👽","💀", "🤡", "👺", "🧙🏼","🙀", "😱", "☠️", "🕸️"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 1) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    //mark variable so that it sends an ObservableObject.send() when it changes
    @Published private var model = createMemoryGame()

    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
  
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }

    func choose(_ card: Card) {
        model.choose(card: card)
    }
    
}
