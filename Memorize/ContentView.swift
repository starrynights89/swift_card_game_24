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
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            themeChoice
        }
        .padding()
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
            selectedArray = emojisTravel.indices.map {
                index in Card(content: emojisTravel[index], id: "\(emojisTravel[index])\(index)", isFaceUp: true)
            } + emojisTravel.indices.map {
                index in Card(content: emojisTravel[index], id: "\(emojisTravel[index])\(index+emojisTravel.count)", isFaceUp: true)
            }
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
            selectedArray = emojisHalloween.indices.map {
                index in Card(content: emojisHalloween[index], id: "\(emojisHalloween[index])\(index)", isFaceUp: true)
            } + emojisHalloween.indices.map {
                index in Card(content: emojisHalloween[index], id: "\(emojisHalloween[index])\(index+emojisHalloween.count)", isFaceUp: true)
            }
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
            selectedArray = emojisAnimals.indices.map {
                index in Card(content: emojisAnimals[index], id: "\(emojisAnimals[index])\(index)", isFaceUp: true)
            } + emojisAnimals.indices.map {
                index in Card(content: emojisAnimals[index], id: "\(emojisAnimals[index])\(index+emojisAnimals.count)", isFaceUp: true)
            }
            print("Selected Array Count: \(selectedArray.count)")
        }) {
            VStack{
                Image(systemName: "dog.fill")
                Text("Animals")
            }
        }
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
