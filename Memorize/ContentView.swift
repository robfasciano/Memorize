//
//  ContentView.swift
//  Memorize
//
//  Created by Robert Fasciano on 10/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack  {
            CardView(isFaceUp: false)
            CardView()
            CardView()
            CardView()
        }
        .foregroundStyle(.cyan)
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp = true
    
    var body: some View {
        ZStack {
 //           let base = Circle()
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 3)
                Text("😍").font(.largeTitle)
            } else {
                base
            }
        }
    }
}

#Preview {
    ContentView()
}
