//
//  EmojiMemoryGameView.swift
//  Memorize
//  is a View
//  Created by Robert Fasciano on 10/4/24.
//

import SwiftUI
import UIKit

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    //@ObservedObject mark this as something that can cause a redraw
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
                .foregroundStyle(viewModel.color)
            HStack {
                score
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle", systemImage: "sparkles.rectangle.stack") {
            withAnimation {
                viewModel.shuffle() //user intent
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in//cannot use For inside a view
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation() {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
    
}
    
    
#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
