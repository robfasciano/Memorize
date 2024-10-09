//
//  ContentView.swift
//  Memorize
//
//  Created by Robert Fasciano on 10/4/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
//    let emojis: Array<String> = ["👻", "🎃", "👹", "👽"]
//    let emojis: [String] = ["👻", "🎃", "👹", "👽"]
    let emojis = ["👻", "🎃", "👹", "👽","👻", "🎃", "👹", "👽","👻", "🎃", "👹", "👽"]
//    let emojis = "👻🎃👹👽".components(separatedBy: .nonBaseCharacters) //can't get correct seperator

    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<cardCount, id: \.self) { index in//cannot use For inside a view
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)

    }
    
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)

    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action:{
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                    base.foregroundStyle(.white)
                    base.strokeBorder(lineWidth: 3)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.opacity(isFaceUp ? 0 : 1)
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
    }
}

#Preview {
    ContentView()
}
