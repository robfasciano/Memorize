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
    //this is really EmojiMemoryGame.themes, but swift can infer this prefix
    private static let themes = [
        ("Halloween", "👻🎃👹👽💀🤡👺🧙🏼🙀😱☠️🕸️", 8, Color.orange, .black),
        ("Vehicles", "🚔🚍🚘🚖🛵🛺🚗🚕🚌🏎️", nil, Color.purple, nil),
        ("Fruit", "🍏🍎🍐🍊🍋🍌🍇🍓🫐🍒🍑", 6, Color.red, nil),
        ("Animals", "🐶🐱🐭🐹🐰🦊🐻🐼🐸🐷🦁🐻‍❄️🐵", 5, Color.blue, nil),
        ("Smilies", "🎃👹🤡👺😁🤓🐸", 4, Color.yellow, nil),
        ("Ladies", "👩‍🦳👩🏿‍🦳👸🏻🏃‍♀️‍➡️👱🏼‍♀️🦸🏾‍♀️", nil, Color.pink, Color.purple)
    ]
    
    private var theme = 0
    var setName: String = ""
    var cardColor: Color = .black
    var gradientColor: Color?
    private static var cardPairs: Int?

    private static var emojis: [String] = []

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: cardPairs!) { pairIndex in
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
    
    var score: Int {
        if let myModel = model {
            return myModel.cardScore
        } else {
            return 0
        }
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
        var temp: Int?
        
        theme = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        (self.setName, emojisData, temp, cardColor, gradientColor) = EmojiMemoryGame.themes[theme]
        EmojiMemoryGame.cardPairs = temp ?? Int.random(in: 2...emojisData.count)
        
//        print(EmojiMemoryGame.themes[theme])
//        print(emojisData)
//        print(EmojiMemoryGame.cardPairs)
        
        EmojiMemoryGame.emojis = []
        for localEmoji in emojisData {
            EmojiMemoryGame.emojis.append(String(localEmoji))
        }
        EmojiMemoryGame.emojis.shuffle()
        while EmojiMemoryGame.emojis.count > EmojiMemoryGame.cardPairs! {
            EmojiMemoryGame.emojis.removeLast()
        }
        
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
