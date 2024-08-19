//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Hartson on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: Array<String> = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    @State var emojisTravel: Array<String> = ["🚂", "🚀", "✈️", "🛳", "⛵️", "🚲", "🛵", " 🚜",
        "🚃", "🚕", "🚓"]
    
    @State var emojisAnimals: Array<String> = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐮", "🐯", "🦁", "🐤"]
    
    // selected Array
    @State var selectedArray: [String] = []
    
    // combine 3 strings together
    var combinedEmojis: [String] {
        emojis + emojisTravel + emojisAnimals
    }
    
    // set a temporary state for cardCount
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
            themeChoice
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) {
                index in CardView(content: combinedEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(Color.orange)
    }
    
    var themeChoice: some View {
        HStack {
            buttonTravel
            buttonHalloween
            buttonAnimals
        }
        .imageScale(.large)
    }
    
    var buttonTravel: some View {
        Button (action: {
            selectedArray = combinedEmojis
        }) {
            Text("Travel")
        }
    }
    
    var buttonHalloween: some View {
        Button (action: {
            selectedArray = combinedEmojis
        }) {
            Text("Halloween")
        }
    }
    
    var buttonAnimals: some View {
        Button (action: {
            selectedArray = combinedEmojis
        }) {
            Text("Animals")
        }
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
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        // disable card count button if less than one or greater than the emoji string array
        .disabled(cardCount + offset < 1 || cardCount + offset > combinedEmojis.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
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
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
