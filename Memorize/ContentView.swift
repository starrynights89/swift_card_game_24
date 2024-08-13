//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Hartson on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: false)
            CardView()
            CardView(isFaceUp: true)
            CardView(isFaceUp: true)
        }
        .foregroundColor(Color.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            // local variable constant
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
