//
//  GameModel.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import Foundation

// GameModel contains configuration items that controls the inner workings of
// the game.
class GameModel:Codable {
   
    // Defines the number range of the challenges.
    // Numbers occuring in the game should not exceed this range.
    // Terms in additions and subtractions should be chosen carefully such
    // that neither the terms nor their sums / differences exceet this
    // number range.
    // The range will normally start with 0, thus only the upper gets
    // specified.
    var numberRangeUpperLimit:Int = 10;
    
    // Score necessary to win the game and become Rechenkaiser.
    // For each correctly answered challenge the player scores 1 point.
    var winningScore = 120;
    
    // Penalty for failing a challenge
    var penalty = 15;
    
    // Define whether negative numbers are allowed.
    // If negative numbers are allowed then the number range effectively
    // goes from -upperLimit to upperLimit.
    var negativeNumbersAllowed: Bool = false;
    
    // shall the system create challenges using dice faces
    var createDiceChallenges:Bool = true;
    
    // shall the system create challenges using numbers
    var createNumberChallenges:Bool = true;
    
    // shall the system create addition challenges
    var createAdditionChallenges:Bool = true;
    
    // shall the system create subtraction challenges
    var createSubtractionChallenges:Bool = true;
    
    // shall the system create multiplication challenges
    var createMultiplicationChallenges:Bool = false;

    // shall the system create division challenges
    var createDivisionChallenges:Bool = false;

    func isDiceFaceAvailableForNumber(_ number:Int)->Bool {
        return 1 <= number && number <= 9
    }

}
