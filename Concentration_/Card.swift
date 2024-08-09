//
//  Card.swift
//  Concentration_
//
//  Created by Selam Mekonen on 18/07/2024.
//

import Foundation

struct Card:Hashable
{
//    var hashValue: Int {return identifier}
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    
    static func ==(lhs:Card,rhs:Card) -> Bool{
        lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUP = false
    var isMatched = false
    private var identifier : Int
    
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
 



