//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Hartson on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "🎃", "🕷️", "😈", "😈"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) {
                index in CardView(content: emojis[index])
            }
        }
        .foregroundColor(Color.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    let content: String
    // set a temporary state for isFaceUp
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            // local variable constant
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
