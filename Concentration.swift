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
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            return cards.indices.filter {cards[$0].isFaceUP}.oneAndOnly
            
            //var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUP{
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }else{
//                        foundIndex = nil
//                    }
//                    
//                }
//            }
//            return foundIndex
        }
        
        set{
            for index in cards.indices{
                cards[index].isFaceUP = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at : \(index)): Choosen index not in the card")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // One card face up so check if they match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUP = true
                
                
            } else{
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
