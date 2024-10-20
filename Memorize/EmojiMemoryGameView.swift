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
    
    var body: some View {
        VStack {
            cards.animation(.default, value: viewModel.cards)
            Button("Shuffle", systemImage: "sparkles.rectangle.stack") {
                viewModel.shuffle() //user intent
            }
        }
        .padding()
    }
    
    var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: 2/3
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in//cannot use For inside a view
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundStyle(.orange)
    }
    
    
    func gridWidthThatFits (
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
            
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
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
                    base.foregroundStyle(.white)
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
