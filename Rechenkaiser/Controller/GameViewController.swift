//
//  GameViewController.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ConfigurationViewDelegate {
    
    // MARK: view elements
    @IBOutlet weak var operandImageLeft: UIImageView!
    @IBOutlet weak var operandImageRight: UIImageView!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var progressBar: UILabel!
    @IBOutlet weak var answerTextfield: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelIcon: UIImageView!
    
    // MARK: game logic state
    let gameModel:GameModel = GameModel()
    let motivationLibrary:MotivationLibrary = MotivationLibrary()
    // a collection of strategies that can create challenges.
    // the content of the collection gets updated when the user configures the game
    var challengeGenerators:[ChallengeGenerator] = [ChallengeGenerator]()
    var currentChallenge:Challenge!
    
    var currentScore:Int = 0
    
    // MARK: game logic
    func updateView() {
        let progressBarLength = view.frame.size.width / CGFloat(gameModel.winningScore) * CGFloat(currentScore)
        progressBar.frame.size.width = progressBarLength
        operandImageLeft.image = UIImage(named:"\(currentChallenge.challengeVisual)\(currentChallenge.operand1)")
        operandImageRight.image = UIImage(named:"\(currentChallenge.challengeVisual)\(currentChallenge.operand2)")
        operatorLabel.text = currentChallenge.challengeOperator.rawValue
        
        let currentLevel:Int = Int(8.0 / Double(gameModel.winningScore) * Double(currentScore)) + 1
        levelLabel.text = "Level \(currentLevel)"
        levelIcon.image = UIImage(named:"lvl\(currentLevel)")
        
        answerTextfield.text = ""
        
        print("Status: currentScore:\(currentScore), barLength:\(progressBarLength), currentLevel:\(currentLevel)")
    }
    
    func createChallenge() {
        let challengeGenerator:ChallengeGenerator =
            challengeGenerators[Int.random(in:0..<challengeGenerators.count)]
        currentChallenge = challengeGenerator.generateChallenge(gameModel:gameModel)
        print(currentChallenge.toJsonString())
    }
    
    // callback method for configuration view controller
    func updateGameConfiguration() {
        // how to respond to game config changes?
        challengeGenerators = [ChallengeGenerator]()
        if gameModel.createAdditionChallenges {
            challengeGenerators += [AdditionChallengeGenerator()]
        }
        if gameModel.createSubtractionChallenges {
            challengeGenerators += [SubtractionChallengeGenerator()]
        }
        if gameModel.createMultiplicationChallenges {
            ProgressHUD.showError("Multiplication mode not supported yet",interaction:true)
        }
        if gameModel.createDivisionChallenges {
            ProgressHUD.showError("Division mode not supported yet", interaction:true)
        }
    }
    
    // MARK: event handling
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        if let playerAnswerString = answerTextfield.text,
        let playerAnswer = Int(playerAnswerString),
            playerAnswer == currentChallenge.result {
            // success
            currentScore += 1
            SoundManager.playSound(.correct)
            ProgressHUD.showSuccess(motivationLibrary.getRandomQuoteForCorrectAnswer())
            createChallenge()
            updateView()
        } else {
            // failure
            currentScore = max(0, currentScore - gameModel.penalty)
            SoundManager.playSound(.wrong)
            ProgressHUD.showError(motivationLibrary.getRandomQuoteForIncorrectAnswer())
            updateView()
        }
    }
    
    @IBAction func configButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier:"configSegue", sender:self);
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "configSegue" {
            let configViewController:ConfigurationViewController = segue.destination as! ConfigurationViewController;
            configViewController.delegate = self;
        }
    }
    
    // MARK: view controller - overriding methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateGameConfiguration()
        createChallenge()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        answerTextfield.becomeFirstResponder()
        answerTextfield.text = ""
    }
}
