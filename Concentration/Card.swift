//
//  Card.swift
//  Concentration
//
//  Created by Krakenn  on 4/25/18.
//  Copyright © 2018 Revelation Tech. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp : Bool = false
    var isMatched : Bool = false
    var identifier : Int
    var firstTouch = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
     init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
