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
    private let dealAnimation: Animation = .easeInOut(duration: 0.25)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50

    
    var body: some View {
        VStack {
            cards
                .foregroundStyle(viewModel.color)
            HStack {
                score
                Spacer()
                deck.foregroundStyle(viewModel.color)
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
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio, lastChange: lastScoreChange) { card in//cannot use For inside a view
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }

    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter {!isDealt($0)}
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View{
        ZStack {
            ForEach(undealtCards) { card in
                    CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation() {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    

    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId: id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
}
    
    
#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
