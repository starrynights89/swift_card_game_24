//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Hartson on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojisHalloween: Array<String> = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    @State var emojisTravel: Array<String> = ["🚂", "🚀", "✈️", "🛳", "⛵️", "🚲", "🛵", "🚜", "🚃", "🚕", "🚓", "🚗"]
    
    @State var emojisAnimals: Array<String> = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐮", "🐯", "🦁", "🐤"]
    
    // selected Array stores button clicked
    @State var selectedArray: Array<Card> = []
    
    var body: some View {
            title
            ScrollView {
                cards
            }
            .padding()
            themeChoice
    }
    
    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
            ForEach(selectedArray) {
                card in CardView(content: card.content, isFaceUp: card.isFaceUp)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        flipCard(card: card)
                }
            }
        }
        .foregroundColor(Color.orange)
        .padding()
    }
    
    var themeChoice: some View {
        HStack {
            Spacer()
            buttonTravel
            Spacer()
            buttonHalloween
            Spacer()
            buttonAnimals
            Spacer()
        }
        .imageScale(.large)
    }
    
    var buttonTravel: some View {
        Button (action: {
            let selectedEmojis = Array(emojisTravel.prefix(8)) // Select first 6 emojis
            selectedArray = createPairs(from: selectedEmojis)
            print("Selected Array Count: \(selectedArray.count)")
        }) {
            VStack {
                Image(systemName: "car.fill")
                Text("Vehicles")
            }
        }
    }
    
    var buttonHalloween: some View {
        Button (action: {
            let selectedEmojis = Array(emojisHalloween.prefix(12)) // Select first 5 emojis
            selectedArray = createPairs(from: selectedEmojis)
            print("Selected Array Count: \(selectedArray.count)")
        }) {
            VStack{
                Image(systemName: "moon.fill")
                Text("Halloween")
            }
        }
    }
    
    var buttonAnimals: some View {
        Button (action: {
            let selectedEmojis = Array(emojisAnimals.prefix(6)) // Select first 6 emojis
            selectedArray = createPairs(from: selectedEmojis)
            print("Selected Array Count: \(selectedArray.count)")
        }) {
            VStack{
                Image(systemName: "dog.fill")
                Text("Animals")
            }
        }
    }
    
    // function takes an array of selected emojis and creates two Card objects for each emoji (one for each pair)
    func createPairs(from emojis: [String]) -> [Card] {
            var cards: [Card] = []
            for index in emojis.indices {
                let emoji = emojis[index]
                cards.append(Card(content: emoji, id: "\(emoji)\(index)", isFaceUp: false))
                cards.append(Card(content: emoji, id: "\(emoji)\(index+emojis.count)", isFaceUp: false))
            }
            return cards.shuffled() // Shuffle to randomize card order
    }
    
    // Updates the state when a card is tapped
    func flipCard(card: Card) {
        if let index = selectedArray.firstIndex(where: { $0.id == card.id }) {
            selectedArray[index].isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}

// Card Identifiable helps SwiftUI distinguish between cards
struct Card: Identifiable {
    let content: String
    let id: String
    var isFaceUp: Bool
}

struct CardView: View {
    let content: String
    // set a temporary state for isFaceUp
    @State var isFaceUp: Bool
    
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
