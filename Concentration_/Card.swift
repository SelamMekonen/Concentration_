//
//  Card.swift
//  Concentration_
//
//  Created by Selam Mekonen on 18/07/2024.
//

import Foundation

struct Card
{
    var isFaceUP = false
    var isMatched = false
    var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int
    {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
 
