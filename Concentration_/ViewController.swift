//
//  ViewController.swift
//  Concentration_
//
//  Created by Selam Mekonen on 11/07/2024.
//

import UIKit

class ViewController: UIViewController 
{
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // As long as all its var are initialized
    
    var numberOfPairsOfCards :Int{
        // If read only property no need for get and set
            return (cardButtons.count+1)/2
        
    }
    private(set) var flipCount = 0 {
        didSet{
            let attribute: [NSAttributedString.Key:Any] = [
                .strokeWidth:5.0,
                .strokeColor:UIColor.orange
                
            ]
                
            
            let attributedText = NSAttributedString(string: "Flips: \(flipCount)", attributes: attribute)
            flipCountLabel.attributedText = attributedText
        }
    }
    

//    private var emojiChoices = ["👻","🎃","😱","🤡","😈", "🤖", "🍭", "🍬", "🍎"]
    private var emojiChoices = "👻🎃😱🤡😈🤖🍭🍬🍎"
    
    
    private var emoji = Dictionary<Card,String>()
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!

    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("Chosen card was not in cardButtons.")
        }
 
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUP{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
            
        }
    }
    

    
    private func emoji(for card : Card) -> String {
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arch4random)
            emoji[card] = String(emojiChoices.remove(at:randomStringIndex))
        }
        return emoji[card] ?? "?"
        
        
    }
    
    //TODO: Restart Game
    
    @IBAction func touchedRestartButton(_ sender: UIButton) {
        game.restartGame()
        flipCount = 0
        updateViewFromModel()
    }
  }
    
    
        



extension Int{
    var arch4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}


    




