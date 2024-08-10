//
//  Concentration.swift
//  Concentration_
//
//  Created by Selam Mekonen on 18/07/2024.
//

import Foundation

class Concentration 
{
    private(set) var cards = Array<Card>()
    var scoreCount:Int = 0
    var flipCount:Int = 1
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            return cards.indices.filter {cards[$0].isFaceUP}.oneAndOnly
        }
        
        set{
            for index in cards.indices{
                cards[index].isFaceUP = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        flipCount += 1
        assert(cards.indices.contains(index), "Concentration.chooseCard(at : \(index)): Choosen index not in the card")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // One card face up so check if they match
                if cards[matchIndex] == cards[index]{
                    scoreCount += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }else{
                    scoreCount-=1
                }
                cards[index].isFaceUP = true
                
                
            } else{
                indexOfOneAndOnlyFaceUpCard = index
                
                
            }
            
        }
        
    }
    
    func restartGame(){
        flipCount = 0
        scoreCount = 0
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUP = false
            cards[flipDownIndex].isMatched = false
        }
        
        cards.shuffle()
        
    }
    
    init(numberOfPairsOfCards:Int)
    {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at : \(numberOfPairsOfCards)): You must have atleast one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            
            cards += [card, card]
            
        }
        
        // TODO: Shuffle the cards
         
        
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first:nil
    }
}
