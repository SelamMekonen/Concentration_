//
//  Concentration.swift
//  Concentration_
//
//  Created by Selam Mekonen on 18/07/2024.
//

import Foundation

class Concentration 
{
    var cards = Array<Card>()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // One card face up so check if they match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUP = true
                indexOfOneAndOnlyFaceUpCard = nil
                
                
            } else{
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUP = false
                }
                cards[index].isFaceUP = true
                indexOfOneAndOnlyFaceUpCard = index
                
                
            }
            
        }
        
    }
    
    func restartGame(){
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUP = false
            cards[flipDownIndex].isMatched = false
        }
        
        cards.shuffle()
        
    }
    
    init(numberOfPairsOfCards:Int)
    {
        
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            
            cards += [card, card]
            
        }
        
        // TODO: Shuffle the cards
         
        
    }
}
