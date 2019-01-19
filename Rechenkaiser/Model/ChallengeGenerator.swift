//
//  ChallengeGenerator.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 20.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import Foundation

protocol ChallengeGenerator {
    func generateChallenge(numberRangeUpperLimit:Int)->Challenge
}

class AdditionChallengeGenerator:ChallengeGenerator {
    func generateChallenge(numberRangeUpperLimit: Int)->Challenge {
        let operand1:Int = Int.random(in: 1...numberRangeUpperLimit);
        let operand2:Int = Int.random(in: 1...(numberRangeUpperLimit-operand1));
        let sum:Int = operand1 + operand2
        assert(operand1 <= numberRangeUpperLimit && operand2 <= numberRangeUpperLimit && sum <= numberRangeUpperLimit);
        assert(operand1 >= 0 && operand2 >= 0 && sum >= 0);
        return Challenge(operand1:operand1, operand2:operand2, result:sum, challengeOperator: .plus);
    }
    
    
}

class SubtractionChallengeGenerator:ChallengeGenerator {
    func generateChallenge(numberRangeUpperLimit: Int)->Challenge {
        var operand1:Int = Int.random(in: 1...numberRangeUpperLimit);
        var operand2:Int = Int.random(in: 1...numberRangeUpperLimit);
        if operand1 < operand2 {
            let buffer:Int = operand1;
            operand1 = operand2;
            operand2 = buffer;
        }
        let result = operand1 - operand2;
        assert(operand1 <= numberRangeUpperLimit && operand2 <= numberRangeUpperLimit && result <= numberRangeUpperLimit);
        assert(operand1 >= 0 && operand2 >= 0 && result >= 0);
        return Challenge(operand1:operand1, operand2:operand2, result:result, challengeOperator: .minus);
    }
    
    
}
