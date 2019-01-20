//
//  MotivationLib.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 30.12.18.
//  Copyright © 2018 Poorman's Castle. All rights reserved.
//

import Foundation

// a library of motiviational quotes to be displayed when the player did
// something right or wrong.
class MotivationLibrary {
    
    let quotesForCorrectAnswer:[String]
    let quotesForIncorrectAnswer:[String]
    
    init(){
        quotesForCorrectAnswer = [
            "Fantastisch",
            "Gut gemacht!",
            "Ja!",
            "Klasse!",
            "Mach weiter so!",
            "Nicht übel!",
            "Prima!",
            "Sehr gut!",
            "Super!",
            "Toll!",
            "Weiter so!",
            "Wow!",
            "😊",
            "🐈",
            "🐱",
            "😹",
            "😀",
            "🤩",
            "😎",
            "😺",
            "😻",
            "😸",
            "🐶",
            "🐩",
            "😽",
            "🙆",
            "👍",
            "👏"
        ];
        
        quotesForIncorrectAnswer = [
            "Das ging schon mal besser!",
            "Du kannst es besser!",
            "Jetzt nicht nachlassen!",
            "Konzentration!",
            "Leider falsch!",
            "Mehr üben!",
            "Nein!",
            "Nicht aufgeben!",
            "Versuchs nochmal!",
            "Weiter üben!",
            "😠",
            "😖",
            "😾",
            "😿",
            "🙀",
            "🙅",
            "🤦",
            "🤦‍♀️"
        ]
    }
    
    func getRandomQuoteForCorrectAnswer()->String{
        return quotesForCorrectAnswer[Int.random(in:0..<quotesForCorrectAnswer.count)];
    }
    
    func getRandomQuoteForIncorrectAnswer()->String{
        return quotesForIncorrectAnswer[Int.random(in:0..<quotesForIncorrectAnswer.count)];
    }
    
}
