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
    
    // MARK: data required by the business logic
    var summand1:Int = 0;
    var summand2:Int = 0;
    var sum:Int = 0;
    
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
            createChallenge();
            updateView();
        } else {
            ProgressHUD.showError(motivationLibrary.getRandomQuoteForIncorrectAnswer());
        }
    }
    
    // challenge consists of two summands and a sum. The summands will be
    // displayed as dice faces, the sum has to be entered by the player in
    // the text field
    func createChallenge(){
        summand1 = Int.random(in:1...6);
        summand2 = Int.random(in:1...6);
        sum = summand1 + summand2;
    }
    
    // updates the dice views to represent the current challenge, and resets
    // the content of the text field
    func updateView(){
        diceImageLeft.image = UIImage(named:"dice\(summand1)");
        diceImageRight.image = UIImage(named:"dice\(summand2)");
        answerTextfield.text = "";
    }
    
}

