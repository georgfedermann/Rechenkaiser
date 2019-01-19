//
//  Challenge.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import Foundation

enum ChallengeOperator:String {
    case plus = "+"
    case minus = "-"
}

// Represents a challenge that gets presented to the player. 
class Challenge {
    
    var operand1:Int
    var operand2:Int
    var result:Int
    var challengeOperator:ChallengeOperator
    
    init(operand1 op1:Int, operand2 op2:Int, result resultArg:Int, challengeOperator op:ChallengeOperator){
        operand1 = op1
        operand2 = op2
        result = resultArg
        challengeOperator = op
    }
    
    func wasChallengeAnsweredCorrectly(response:Int)->Bool{
        return response == result
    }
    
}
