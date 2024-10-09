//
//  ContentView.swift
//  Memorize
//
//  Created by Robert Fasciano on 10/4/24.
//

import SwiftUI

struct ContentView: View {
//    let emojis: Array<String> = ["👻", "🎃", "👹", "👽"]
//    let emojis: [String] = ["👻", "🎃", "👹", "👽"]
    let emojis = ["👻", "🎃", "👹", "👽"]

    var body: some View {
        HStack  {
            ForEach(emojis.indices, id: \.self) { index in//cannot use For inside a view
                CardView(content: emojis[index])
            }
        }
        .foregroundStyle(.orange)
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
