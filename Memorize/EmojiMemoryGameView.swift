//
//  EmojiMemoryGameView.swift
//  Memorize
//  is a View
//  Created by Robert Fasciano on 10/4/24.
//

import SwiftUI
import UIKit

struct EmojiMemoryGameView: View {
    //@ObservedObject mark this as something that can cause a redraw
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var gameStarted = false
    
    var body: some View {
        VStack {
            Text(gameStarted ? viewModel.setName : "Select New")
                .font(.largeTitle)
                .fontWeight(.black)
            ScrollView {
                if gameStarted {
                    if viewModel.noCardPairsLeft {
                        gameComplete
                    } else {
                        cards.animation(.default, value: viewModel.cards)
                    }
                }
            }
            bottomButtons
        }
        .padding()
    }
    
    var bottomButtons: some View {
        HStack {
            newGameButton
            Spacer()
            scoreDisplay
            Spacer()
            shuffleButton
        }
    }
    
    //Krungthep, Impact, 7x13Normal:  not sure why only Impact works
    var scoreDisplay: some View {
        Text(String(viewModel.score))
            .font(.custom("Impact", fixedSize: 36))
            .foregroundStyle(viewModel.score < 0 ? .red : .black)
    }
    
    
    var shuffleButton: some View {
        Button(action: {
            viewModel.shuffle() //user intent
        })
        {
            VStack {
                Image(systemName: "sparkles.rectangle.stack")
                    .font(.largeTitle)
                Text("Shuffle")
            }
        }
        .disabled(!gameStarted)
    }
    
    var newGameButton: some View {
        Button(action: {
            viewModel.start() //user intent
            gameStarted = true
            viewModel.shuffle()
        })
        {
            VStack {
                if !gameStarted || viewModel.noCardPairsLeft {
                    Image(systemName: "play.square.stack")
                        .font(.largeTitle)
                        .symbolEffect(.wiggle.down.byLayer, options: .repeat(.periodic(delay: 1.5)))
                } else {
                    Image(systemName: "play.square.stack")
                        .font(.largeTitle)
                }
                Text("New")
            }
        }
    }
    
    
    
    var gameComplete: some View {
        
        VStack {
            Spacer()
            Image(systemName: "hand.thumbsup")
                .symbolEffect(.bounce.up.byLayer, options: .nonRepeating)
                .font(.system(size:200))
                .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(viewModel.cardColor)
            Spacer()
        }
    }
    
    var cards: some View {
        let localColor = viewModel.gradientColor ?? viewModel.cardColor
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in//cannot use For inside a view
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(Gradient(colors: [viewModel.cardColor, localColor]))
    }
    
    struct CardView: View {
        let card: MemoryGame<String>.Card
        
        init(_ card: MemoryGame<String>.Card) {
            self.card = card
        }
        
        var body: some View {
            ZStack{
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.foregroundStyle(.teal)
                    base.strokeBorder(lineWidth: 3)
                    Text(card.content)
                        .font(.system(size:200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                }
                .opacity(card.isFaceUp ? 1 : 0)
                base.opacity(card.isFaceUp ? 0 : 1)
            }
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
