//
//  ViewController.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 30.12.18.
//  Copyright © 2018 Poorman's Castle. All rights reserved.
//

import UIKit

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
            ProgressHUD.showSuccess(motivationLibrary.getRandomQuoteForCorrectAnswer());
            correctStreakCount += 1;
            checkLevelClimb();
            createChallenge();
            updateView();
        } else {
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
            currentLevel = min(2, currentLevel + 1);
        }
    }
    
    // challenge consists of two summands and a sum. The summands will be
    // displayed as dice faces, the sum has to be entered by the player in
    // the text field
    func createChallenge(){
        if(currentLevel == 1){
            summand1 = Int.random(in:1...6);
            summand2 = Int.random(in:1...6);
        } else if (currentLevel == 2){
            summand1 = Int.random(in:1...9);
            summand2 = Int.random(in:1...9);
        }
        sum = summand1 + summand2;
    }
    
    // updates the dice views to represent the current challenge, and resets
    // the content of the text field
    func updateView(){
        diceImageLeft.image = UIImage(named:"dice\(summand1)");
        diceImageRight.image = UIImage(named:"dice\(summand2)");
        answerTextfield.text = "";
        levelLabel.text = "Level \(currentLevel)";
        levelIcon.image = UIImage(named:"lvl\(currentLevel)");
    }
    
}

