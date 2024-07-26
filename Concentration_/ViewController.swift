//
//  ViewController.swift
//  Concentration_
//
//  Created by Selam Mekonen on 11/07/2024.
//

import UIKit

class ViewController: UIViewController 
{
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    // As long as all its var are initialized
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("Chosen card was not in cardButtons.")
        }
 
        
    }
    
    func updateViewFromModel() {
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
    
    var emojiChoices = ["👻","🎃","😱","🤡","😈", "🤖", "🍭", "🍬", "🍎"]
    
    var emoji = Dictionary<Int,String>()
    
    func emoji(for card : Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
        
        
    }
    //TODO: Restart Game
    
    @IBAction func TouchedRestartButton(_ sender: UIButton) {
        game.restartGame()
        flipCount = 0
        updateViewFromModel()
    }
    
    
        
    }
    




