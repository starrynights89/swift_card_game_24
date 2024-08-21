//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Alexander Hartson on 8/21/24.
//

import Foundation

struct MemorizeGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
