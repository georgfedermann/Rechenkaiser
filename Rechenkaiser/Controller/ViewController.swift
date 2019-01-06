//
//  ViewController.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 30.12.18.
//  Copyright © 2018 Poorman's Castle. All rights reserved.
//

import UIKit

enum ChallengeFace {
    case dice
    case number
}

class ViewController: UIViewController {
    
    // MARK: IB references
    @IBOutlet weak var diceImageLeft: UIImageView!
    @IBOutlet weak var diceImageRight: UIImageView!
    @IBOutlet weak var answerTextfield: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelIcon: UIImageView!
    
    // MARK: data required by the business logic
    var summand1:Int = 0;
    var summand2:Int = 0;
    var sum:Int = 0;
    // levels 1..4 have dice faces, levels 5..8 have number faces
    var challengeFace:ChallengeFace = .dice;
    
    // MARK: level management
    // to proceed to next level, 15 challenges have to be done correctly
    // on the first try in sequence
    var correctStreakCount:Int = 0;
    // how many correct answers in a row are necessary for a level pump
    var correctStreakSizeForLevelPump:Int = 15;
    var currentLevel = 1;
    
    let motivationLibrary:MotivationLibrary = MotivationLibrary();
    
    // MARK: ViewController customizations
    override func viewDidLoad() {
        super.viewDidLoad();
        createChallenge();
        updateView();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        answerTextfield.becomeFirstResponder();
    }
    
    // MARK: event handlers
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        if let playerAnswerString = answerTextfield.text,
            let playerAnswer = Int(playerAnswerString),
            playerAnswer == sum {
            SoundManager.playSound(.correct);
            ProgressHUD.showSuccess(motivationLibrary.getRandomQuoteForCorrectAnswer());
            correctStreakCount += 1;
            checkLevelClimb();
            createChallenge();
            updateView();
        } else {
            SoundManager.playSound(.wrong);
            ProgressHUD.showError(motivationLibrary.getRandomQuoteForIncorrectAnswer());
            ProgressHUD.showError("You lose a level 😖");
            correctStreakCount = 0;
            currentLevel = max(1, currentLevel - 1);
            updateView();
        }
    }
    
    func checkLevelClimb(){
        if(correctStreakCount == correctStreakSizeForLevelPump){
            ProgressHUD.showSuccess("You gain a level 🏅");
            correctStreakCount = 0;
            currentLevel = min(8, currentLevel + 1);
        }
    }
    
    // challenge consists of two summands and a sum. The summands will be
    // displayed as dice faces, the sum has to be entered by the player in
    // the text field.
    // lvl 1-4 have dice faces
    // lvl 5-8 have number faces
    // lvl 1-4 number range is 6, 7, 8, 9 respectively
    // lvl 5-8 number range is 7, 7, 8, 9 respectively
    func createChallenge(){
        // define the range of numbers from which summands in this level can be taken.
        let validRangeForLevel:ClosedRange<Int> = 1...(6+(currentLevel-1)%4);
        print("Creating a challenge for level \(currentLevel) in the range of \(validRangeForLevel).");
        challengeFace = currentLevel < 5 ? .dice : .number;
        summand1 = Int.random(in:validRangeForLevel);
        summand2 = Int.random(in:validRangeForLevel);
        sum = summand1 + summand2;
    }
    
    // updates the dice views to represent the current challenge, and resets
    // the content of the text field
    func updateView(){
        diceImageLeft.image = UIImage(named:"\(challengeFace)\(summand1)");
        diceImageRight.image = UIImage(named:"\(challengeFace)\(summand2)");
        answerTextfield.text = "";
        levelLabel.text = "Level \(currentLevel)";
        levelIcon.image = UIImage(named:"lvl\(currentLevel)");
    }
    
}

