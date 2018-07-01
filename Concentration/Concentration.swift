//
//  Concentration.swift
//  Concentration
//
//  Created by Krakenn  on 4/25/18.
//  Copyright © 2018 Revelation Tech. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var orderedCards = [Card]()
    
    var emojiChoices = [String]()
    
    var usedCards = [Int:Int]()
    
    var flipCount = 0
    
    var points = 0
    //var firstFlip = false
    var firstTouch = true
    var indexOfOneAndOnlyCard : Int? {
        get {
            var foundIndex:Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else {
                        foundIndex = nil
                    }
                }
            }
        return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (newValue == index)
            }
        }
    }
    
    var themeArray : Array = [Theme.animals,Theme.halloween,Theme.faces,Theme.buildings,Theme.symbols, Theme.sports]
    
    func chooseCard(at index:Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyCard , matchIndex != index {
                //Check if card are match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    points += 2
                }else{
                    // Check wether the two cards have been seen
                    if usedCards[matchIndex] != nil && usedCards[index] != nil{
                        points -= 2
                    }// Check if either on of two cards was already seen
                    else if usedCards[matchIndex] != nil || usedCards[index] != nil {
                        points -= 1
                    }else {
                        usedCards[matchIndex] = cards[matchIndex].identifier
                        usedCards[index] = cards[index].identifier
                    }
                }
                flipCount += 1
                cards[index].isFaceUp = true
                //indexOfOneAndOnlyCard = nil
                firstTouch = true
                usedCards[index] = cards[index].identifier
            
            }else{
                /*
                //Make all the cards face down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                if firstTouch == true {
                    flipCount += 1
                }*/
                if firstTouch == true {
                    flipCount += 1
                }
                indexOfOneAndOnlyCard = index
            }
        
            
        }
    }
    
    init(numberOfPairsOfCards:Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            orderedCards += [card,card]
        }
        //TODO: SHUFFLE THE CARDS
        for _ in 0..<orderedCards.count {
            let rand = Int(arc4random_uniform(UInt32(orderedCards.count)))
             cards.append(orderedCards[rand])
             orderedCards.remove(at: rand)
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(themeArray.count)))
        let randomTheme = themeArray[randomIndex]
        
        switch randomTheme {
            case .animals:
                emojiChoices = ["🐙","🦑","🦉","🦄","🐣", "🐋","🐵","🐼","🐯","🐶"]
            case .buildings:
                emojiChoices = ["🏫","🏣","🏬","🏘","🏠","🕍","🕌","🏛","💒","🏦","🏪","🏭"]
            case .faces:
                emojiChoices = ["😀","😃","😡","😭","🤬","🤢","🤓","🙄","🤯","🤗","😇","😎"]
            case .halloween:
                emojiChoices = ["🎃","👻","😱","🧟‍♀️","🤡","💀","😾","🍭","😈"]
            case .sports:
                emojiChoices = ["🥋","⚽️","🏈","🥅","🏌🏽‍♂️","🏄🏿‍♂️","⛹🏼‍♀️","🥊","🏹","⛳️"]
            case .symbols:
                emojiChoices = ["🎵","✝️","✴️","🚫","🈶","⚛️","♨️","〽️","🛑","✅"]
            default:
                break
        }
    }
    
    enum Theme {
        
        case halloween
        case faces
        case animals
        case buildings
        case sports
        case symbols
        
    }
    
}
