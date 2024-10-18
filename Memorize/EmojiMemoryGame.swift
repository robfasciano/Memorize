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
        ("Halloween", "👻🎃👹👽💀🤡👺🧙🏼🙀😱☠️🕸️", 2, Color.orange),
        ("Vehicles", "🚔🚍🚘🚖🛵🛺🚗🚕🚌🏎️", 3, Color.purple),
        ("Fruit", "🍏🍎🍐🍊🍋🍌🍇🍓🫐🍒🍑", 2, Color.red),
        ("Animals", "🐶🐱🐭🐹🐰🦊🐻🐼🐸🐷🦁🐻‍❄️🐵", 3, Color.blue),
        ("Smilies", "🎃👹🤡👺😁🤓🐸", 2, Color.yellow),
        ("Ladies", "👩‍🦳👩🏿‍🦳👸🏻🏃‍♀️‍➡️👱🏼‍♀️🦸🏾‍♀️", 3, Color.pink)
    ]
    
    private var theme = 0
    private var setName: String = ""

    private static var emojis: [String] = []

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    //mark variable @Published so that it send an ObservableObject.send() when it changes
//    @Published private var model = createMemoryGame()
    @Published private var model: MemoryGame<String>?

    var cards: Array<MemoryGame<String>.Card> {
        return model!.cards  //FIXME: should not force unwrap
    }
  
    // MARK: - Intents
    func shuffle() {
        model?.shuffle()
        objectWillChange.send()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model?.choose(card: card)
    }
    
    
    
    func start() {
        var emojisData: String
        
        theme = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        (self.setName, emojisData, _, _) = EmojiMemoryGame.themes[theme]
        //print(EmojiMemoryGame.themes[theme])
        EmojiMemoryGame.emojis = []
        for localEmoji in emojisData {
            EmojiMemoryGame.emojis.append(String(localEmoji))
        }
        EmojiMemoryGame.emojis.shuffle()
        while EmojiMemoryGame.emojis.count > 4 {
            EmojiMemoryGame.emojis.removeLast()
        }
        EmojiMemoryGame.emojis += EmojiMemoryGame.emojis
        print(self.setName, EmojiMemoryGame.emojis)
        
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
