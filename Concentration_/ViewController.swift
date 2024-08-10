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
    
    private(set) var scoreCount = 0 {
        didSet{
            let attribute: [NSAttributedString.Key:Any] = [
                .strokeWidth:5.0,
                .strokeColor:UIColor.orange
                
            ]
        
            
            let attributedText = NSAttributedString(string: "Score: \(scoreCount)", attributes: attribute)
            scoreLable.attributedText = attributedText
        }
    }

    



    private var emojiChoices = ["👻🎃😱🤡😈🤖🍭🍬🍎", "🐶🐱🐭🐰🦊🐻🐼🐨🐯", "🍎🍊🍋🍌🍉🍇🍓🍒🍍", "⚽️🏀🏈⚾️🎾🏐🏓🏸🏒", "🌲🌳🌵🌸🌼🌻🌺🍁🍂", "🚗🚕🚙🚌🚎🏎🚓🚑🚒", "🍔🍕🍟🌭🍿🍩🍪🍫🍰"]
    
    private lazy var emojiChoice: String = emojiChoices.randomElement() ?? ""
    
    
    private var emoji = Dictionary<Card,String>()
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!

    @IBOutlet private weak var scoreLable: UILabel!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        scoreCount = game.scoreCount
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("Chosen card was not in cardButtons.")
        }
 
        
    }
    
    private func updateViewFromModel() {
        var emojiChoice = emojiChoices.randomElement() ?? ""
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
    
    
   
    
    private func emoji(for card: Card) -> String {
        // Choose a random theme
        // var emojiChoice = emojiChoices.randomElement() ?? ""

        // If the emoji dictionary doesn't already have an emoji for this card and emojiChoice is not empty
        if emoji[card] == nil, emojiChoice.count > 0 {
            // Generate a random index within the bounds of emojiChoice
            let randomStringIndex = emojiChoice.index(emojiChoice.startIndex, offsetBy: emojiChoice.count.arc4random)
            // Assign a random emoji to the card
            emoji[card] = String(emojiChoice.remove(at: randomStringIndex))
        }

        // Return the emoji for the card or "?" if something goes wrong
        return emoji[card] ?? "?"
    }
    
    //TODO: Restart Game
    
    @IBAction func touchedRestartButton(_ sender: UIButton) {
        game.restartGame()
        flipCount = 0
        scoreCount = 0
        emojiChoice = emojiChoices.randomElement() ?? ""
        updateViewFromModel()
    }
  }
    
    
        



extension Int{
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}


    




