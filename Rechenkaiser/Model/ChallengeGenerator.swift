//
//  ChallengeGenerator.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 20.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import Foundation

protocol ChallengeGenerator {
    func generateChallenge(gameModel:GameModel)->Challenge
}

extension ChallengeGenerator {
    func decideOnVisualPresentation(gameModel:GameModel)->ChallengeVisual {
        var options:[ChallengeVisual] = [ChallengeVisual]()
        if gameModel.createDiceChallenges {
            options += [.dice]
        }
        if gameModel.createNumberChallenges {
            options += [.number]
        }
        assert(options.count > 0)
        return options[Int.random(in:0..<options.count)]
    }
}

class AdditionChallengeGenerator:ChallengeGenerator {
    func generateChallenge(gameModel:GameModel)->Challenge {
        let operand1:Int = Int.random(in: 0...gameModel.numberRangeUpperLimit);
        let operand2:Int = Int.random(in: 0...(gameModel.numberRangeUpperLimit-operand1));
        let sum:Int = operand1 + operand2
        assert(operand1 <= gameModel.numberRangeUpperLimit &&
            operand2 <= gameModel.numberRangeUpperLimit && sum <= gameModel.numberRangeUpperLimit);
        assert(operand1 >= 0 && operand2 >= 0 && sum >= 0);
        return Challenge(operand1:operand1,
                         operand2:operand2,
                         result:sum,
                         challengeOperator: .plus,
                         visualization: decideOnVisualPresentation(gameModel: gameModel));
    }
}

class SubtractionChallengeGenerator:ChallengeGenerator {
    func generateChallenge(gameModel:GameModel)->Challenge {
        var operand1:Int = Int.random(in: 1...gameModel.numberRangeUpperLimit);
        var operand2:Int = Int.random(in: 1...gameModel.numberRangeUpperLimit);
        if operand1 < operand2 {
            let buffer:Int = operand1;
            operand1 = operand2;
            operand2 = buffer;
        }
        let result = operand1 - operand2;
        assert(operand1 <= gameModel.numberRangeUpperLimit &&
            operand2 <= gameModel.numberRangeUpperLimit && result <= gameModel.numberRangeUpperLimit);
        assert(operand1 >= 0 && operand2 >= 0 && result >= 0);
        return Challenge(operand1:operand1,
                         operand2:operand2,
                         result:result,
                         challengeOperator: .minus,
                         visualization: decideOnVisualPresentation(gameModel: gameModel));
    }
}
