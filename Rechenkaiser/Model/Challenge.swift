//
//  Challenge.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import Foundation

enum ChallengeOperator:String,Codable {
    case plus = "+"
    case minus = "-"
    case times = "•"
    case divide = "÷"
}

enum ChallengeVisual:String,Codable {
    case dice = "dice"
    case number = "number"
}

// Represents a challenge that gets presented to the player. 
class Challenge:Codable {
    
    let operand1:Int
    let operand2:Int
    let result:Int
    let challengeOperator:ChallengeOperator
    let challengeVisual:ChallengeVisual
    
    init(operand1 op1:Int, operand2 op2:Int, result resultArg:Int, challengeOperator op:ChallengeOperator, visualization:ChallengeVisual){
        operand1 = op1
        operand2 = op2
        result = resultArg
        challengeOperator = op
        challengeVisual = visualization
    }
    
    func wasChallengeAnsweredCorrectly(response:Int)->Bool{
        return response == result
    }
    
    func toJsonString()->String {
        // return "{\"operand1\":\(operand1),\"operand2\":\(operand2),\"result\":\(result),\"operator\":\"\(challengeOperator)}"
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return String(data:jsonData, encoding:.utf8)!
    }
    
}
