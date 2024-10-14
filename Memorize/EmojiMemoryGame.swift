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
    //static will make this a Namespace global (also made private)- forced initialization before other class variables
    //this is really EmojiMemoryGame.emoji, but swift can infer this prefix
    private static let themes = [
        ("Halloween", "👻🎃👹👽💀🤡👺🧙🏼🙀😱☠️🕸️", 5, Color.orange)
        ("Vehicles", "🚔🚍🚘🚖🛵🛺🚗🚕🚌🏎️", 5, Color.purple)
        ("Fruit", "🍏🍎🍐🍊🍋🍌🍇🍓🫐🍒🍑", 5, Color.red)
        ("Animals", "👻🎃👹👽💀🤡👺🧙🏼🙀😱☠️🕸️", 5, Color.blue)
        ("Smilies", "👻🎃👹👽💀🤡👺🧙🏼🙀😱☠️🕸️", 5, Color.yellow)
        ("Ladies", "👻🎃👹👽💀🤡👺🧙🏼🙀😱☠️🕸️", 5, Color.pink)
    ]
    private static let emojis = ["👻", "🎃", "👹", "👽","💀", "🤡", "👺", "🧙🏼","🙀", "😱", "☠️", "🕸️"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    //mark variable so that it send an ObservableObject.send() when it changes
    @Published private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
  
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
