//
//  ViewController.swift
//  Concentration
//
//  Created by Krakenn  on 4/17/18.
//  Copyright © 2018 Revelation Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var score: UILabel!
    lazy var game = Concentration(numberOfPairsOfCards:numberOfPairsOfCards)// Classes get a free initializer if all of their instance variables are initialazed
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    let emojis = ["👻","🎃","👻","🎃"]
    
    
    @IBOutlet weak var flipCount: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Ups! Something went absolutely wrong!")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            print("\(cardButtons)")
            let button = cardButtons[index]
            let card = game.cards[index]
            flipCount.text = "Flip Count:\(game.flipCount)"
            score.text = String(game.points)
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5286925797, blue: 0.1878882384, alpha: 1)
            }
        }
        
    }
    
    func flipCard(withEmoji emoji:String, on button:UIButton){
        
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5286925797, blue: 0.1878882384, alpha: 1)
        }else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    
    var emojiChoices = ["🎃","👻","😱","🧟‍♀️","🤡","💀","😾","🍭","😈"]// This must be done in the model and asign the choices in a property
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, game.emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(game.emojiChoices.count)))
            emoji[card.identifier] = game.emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    @IBAction func newGame(_ sender: UIButton) {
        let newGame = Concentration(numberOfPairsOfCards:(cardButtons.count + 1) / 2)
        self.game = newGame
        score.text = String(game.points)
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5286925797, blue: 0.1878882384, alpha: 1)
            button.titleLabel?.text = ""
        }
        
    }
}

