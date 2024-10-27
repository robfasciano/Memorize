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
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
                .foregroundStyle(viewModel.color)
                .animation(.default, value: viewModel.cards)
            Button("Shuffle", systemImage: "sparkles.rectangle.stack") {
                viewModel.shuffle() //user intent
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in//cannot use For inside a view
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}
    
    
#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
